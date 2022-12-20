//
//  FeedbackScreen.swift
//  
//
//  Created by Kamaal M Farah on 20/12/2022.
//

import SwiftUI
import SalmonUI
import ShrimpExtensions

struct FeedbackScreen: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    @ObservedObject private var viewModel: ViewModel

    init(style: FeedbackStyles) {
        self._viewModel = ObservedObject(wrappedValue: ViewModel(style: style))
    }

    var body: some View {
        VStack {
            KFloatingTextField(
                text: $viewModel.title,
                title: "Title".localized(comment: ""))
            KTextView(
                text: $viewModel.description,
                title: "Description".localized(comment: ""))
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
    }

    private func onSendPress() {
        presentationMode.wrappedValue.dismiss()
    }
}

private final class ViewModel: ObservableObject {
    @Published var title = ""
    @Published var description = ""
    @Published private(set) var loading = false

    let style: FeedbackStyles

    init(style: FeedbackStyles) {
        self.style = style
    }

    var disableSubmit: Bool {
        loading || title.trimmingByWhitespacesAndNewLines.isEmpty
    }
}

struct FeedbackScreen_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackScreen(style: .bug)
    }
}
