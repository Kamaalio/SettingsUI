//
//  FeedbackScreen.swift
//
//
//  Created by Kamaal M Farah on 20/12/2022.
//

import SwiftUI
import Logster
import SalmonUI
import PopperUp
import GitHubAPI
import ShrimpExtensions

private let logger = Logster(from: FeedbackScreen.self)

struct FeedbackScreen: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    @EnvironmentObject private var navigator: Navigator

    @ObservedObject private var viewModel: ViewModel

    init(style: FeedbackStyles, description: String = "") {
        self._viewModel = ObservedObject(wrappedValue: ViewModel(style: style, description: description))
    }

    var body: some View {
        VStack {
            KFloatingTextField(
                text: $viewModel.title,
                title: "Title".localized(comment: "")
            )
            KTextView(
                text: $viewModel.description,
                title: "Description".localized(comment: "")
            )
            AppButton(action: onSendPress) {
                AppText(localizedString: "Send", comment: "")
                    .font(.headline)
                    .bold()
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding(.vertical, .extraSmall)
                    .ktakeWidthEagerly()
                    .background(Color.accentColor)
                    .cornerRadius(.small)
            }
            .disabled(viewModel.disableSubmit)
        }
        .padding(.all, .medium)
        .navigationTitle(title: viewModel.style.title, displayMode: .inline)
        .popperUpLite(
            isPresented: $viewModel.showToast,
            style: viewModel.lastToastType?.pupUpStyle ?? .bottom(title: "", type: .warning, description: nil),
            backgroundColor: colorScheme == .dark ? .black : .white
        )
        .accentColor(settingsConfiguration.currentColor)
    }

    private func onSendPress() {
        Task {
            await viewModel.submit(using: settingsConfiguration.feedback, dismiss: {
                #if os(macOS)
                navigator.goBack()
                #else
                presentationMode.wrappedValue.dismiss()
                #endif
            })
        }
    }
}

private final class ViewModel: ObservableObject {
    @Published var title = ""
    @Published var description: String
    @Published private(set) var loading = false
    @Published var showToast = false
    @Published private(set) var toastType: ToastType? {
        didSet { Task { await toastTypeDidSet() } }
    }

    @Published private(set) var lastToastType: ToastType?
    private var toastTimer: Timer?

    let style: FeedbackStyles

    init(style: FeedbackStyles, description: String) {
        self.style = style
        self.description = description
    }

    enum ToastType: Equatable {
        case success
        case failure

        var pupUpStyle: PopperUpStyles {
            PopperUpStyles.bottom(title: title, type: popUpType, description: description)
        }

        private var title: String {
            switch self {
            case .failure:
                return "Sorry, something went wrong".localized(comment: "")
            case .success:
                return "Feedback sent".localized(comment: "")
            }
        }

        private var description: String? {
            switch self {
            case .failure:
                return "Could not send feedback".localized(comment: "")
            case .success:
                return nil
            }
        }

        private var popUpType: PopperUpBottomType {
            switch self {
            case .failure:
                return .error
            case .success:
                return .success
            }
        }
    }

    var disableSubmit: Bool {
        loading || title.trimmingByWhitespacesAndNewLines.isEmpty
    }

    func submit(
        using feedbackConfiguration: SettingsConfiguration.FeedbackConfiguration?,
        dismiss: @escaping () -> Void
    ) async {
        guard let feedbackConfiguration else { return }

        let gitHubAPI = GitHubAPI(token: feedbackConfiguration.token, username: feedbackConfiguration.username)
        await withLoading(completion: {
            let descriptionWithAdditionalFeedback = """
            # User Feedback

            \(description)

            # Additional Data

            \(feedbackConfiguration.additionalDataString ?? "{}")
            """
            let issue: GitHubIssue
            do {
                issue = try await gitHubAPI.repos.createIssue(
                    username: feedbackConfiguration.username,
                    repoName: feedbackConfiguration.repoName,
                    title: title,
                    description: descriptionWithAdditionalFeedback,
                    assignee: feedbackConfiguration.username,
                    labels: feedbackConfiguration.additionalLabels.concat(style.labels)
                ).get()
            } catch {
                logger.error(label: "failed to send feedback", error: error)
                await setToastType(to: .failure)
                return
            }

            logger.info("feedback sent; issue='\(issue)'")
            await setToastType(to: .success)

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                dismiss()
            }
        })
    }

    @MainActor
    private func setToastType(to type: ToastType?) {
        toastType = type
        if type != nil {
            lastToastType = type
        }
    }

    @MainActor
    private func toastTypeDidSet() {
        if toastType != nil {
            if toastTimer != nil {
                toastTimer?.invalidate()
                toastTimer = nil
            }

            showToast = true
            toastTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { [weak self] _ in
                guard let self else { return }

                self.toastTimer?.invalidate()
                self.toastTimer = nil
                Task { await self.setToastType(to: .none) }
            })
        } else {
            showToast = false
            toastTimer?.invalidate()
            toastTimer = nil
        }
    }

    private func withLoading<T>(completion: () async -> T) async -> T {
        await setLoading(true)
        let maybeResult = await completion()
        await setLoading(false)
        return maybeResult
    }

    @MainActor
    private func setLoading(_ state: Bool) {
        loading = state
    }
}

struct FeedbackScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackScreen(style: .bug)
    }
}
