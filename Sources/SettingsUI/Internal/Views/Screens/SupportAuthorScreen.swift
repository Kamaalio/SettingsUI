//
//  SupportAuthorScreen.swift
//
//
//  Created by Kamaal M Farah on 18/12/2022.
//

import Logster
import SwiftUI
import SalmonUI
import PopperUp
import ConfettiSwiftUI

struct SupportAuthorScreen: View {
    @EnvironmentObject private var store: Store

    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        KScrollableForm {
            ZStack {
                VStack {
                    if store.isLoading, !store.hasDonations {
                        KLoading()
                            .ktakeSizeEagerly()
                    }
                    ForEach(store.donations) { donation in
                        AppButton(action: { handlePurchase(donation) }) {
                            DonationView(donation: donation)
                        }
                        .padding(.vertical, .extraSmall)
                        .disabled(!store.canMakePayments)
                    }
                }
                if store.isPurchasing {
                    HStack {
                        KLoading()
                        AppText(localizedString: "Purchasing", comment: "")
                            .font(.headline)
                            .bold()
                    }
                    .ktakeSizeEagerly()
                }
            }
            .padding(.all, .medium)
        }
        .navigationTitle(localizedTitle: "Support Author", comment: "", displayMode: .inline)
        .ktakeSizeEagerly(alignment: .topLeading)
        .onAppear(perform: handleAppear)
        .confettiCannon(
            counter: $viewModel.confettiTimesRun,
            num: viewModel.numberOfConfettis,
            repetitions: viewModel.confettiRepetitions
        )
        .popperUpLite(
            isPresented: $viewModel.showToast,
            style: .bottom(
                title: "Sorry, something went wrong".localized(comment: ""),
                type: .error,
                description: "Failed to make purchase".localized(comment: "")
            ),
            backgroundColor: colorScheme == .dark ? .black : .white
        )
    }

    private func handlePurchase(_ donation: CustomProduct) {
        store.purchaseDonation(donation) { result in
            switch result {
            case .failure:
                viewModel.openToast()
                return
            case .success:
                break
            }

            viewModel.shootConfetti(for: donation)
        }
    }

    private func handleAppear() {
        Task {
            let result = await store.requestProducts()
            switch result {
            case .failure:
                presentationMode.wrappedValue.dismiss()
            case .success:
                break
            }
        }
    }
}

private final class ViewModel: ObservableObject {
    @Published var confettiTimesRun = 0
    @Published private(set) var numberOfConfettis = 20
    @Published private(set) var confettiRepetitions = 0
    @Published var showToast = false
    private var toastTimer: Timer?

    func shootConfetti(for donation: CustomProduct) {
        let weight = donation.weight

        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            if weight > 0 {
                self.confettiRepetitions = weight - 1
            }
            self.numberOfConfettis = 20 * weight
            self.confettiTimesRun += 1
        }
    }

    func openToast() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }

            if self.toastTimer != nil {
                self.toastTimer!.invalidate()
                self.toastTimer = nil
            }

            self.showToast = true
            self.toastTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { [weak self] _ in
                guard let self else { return }

                self.showToast = false
                self.toastTimer?.invalidate()
                self.toastTimer = nil
            })
        }
    }
}

struct SupportAuthorScreen_Previews: PreviewProvider {
    static var previews: some View {
        SupportAuthorScreen()
    }
}
