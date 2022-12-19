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

    @State private var confettiTimesRun = 0
    @State private var numberOfConfettis = 20
    @State private var confettiRepetitions = 0
    @State private var showToast = false

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
        .navigationTitle(localizedTitle: "Support Author", comment: "", displayMode: .large)
        .ktakeSizeEagerly(alignment: .topLeading)
        .onAppear(perform: handleAppear)
        .confettiCannon(counter: $confettiTimesRun, num: numberOfConfettis, repetitions: confettiRepetitions)
        .popperUpLite(
            isPresented: $showToast,
            style: .bottom(
                title: "Sorry, something went wrong".localized(comment: ""),
                type: .error,
                description: "Failed to make purchase".localized(comment: "")),
            backgroundColor: colorScheme == .dark ? .black : .white)
    }

    private func handlePurchase(_ donation: CustomProduct) {
        store.purchaseDonation(donation) { result in
            switch result {
            case .failure:
                showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showToast = false
                }
                return
            case .success:
                break
            }

            shootConfetti(for: donation)
        }
    }

    private func shootConfetti(for donation: CustomProduct) {
        let weight = donation.weight

        DispatchQueue.main.async {
            if weight > 0 {
                confettiRepetitions = weight - 1
            }
            numberOfConfettis = 20 * weight
            confettiTimesRun += 1
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

struct SupportAuthorScreen_Previews: PreviewProvider {
    static var previews: some View {
        SupportAuthorScreen()
    }
}
