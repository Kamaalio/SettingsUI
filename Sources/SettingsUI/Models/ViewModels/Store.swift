//
//  Store.swift
//  
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import Logster
import StoreKit
import Foundation
import ShrimpExtensions

private let logger = Logster(from: Store.self)

/// ViewModel to handle donations logic.
final class Store: NSObject, ObservableObject {
    /// Loading state. View should indicate there is a proccess loading.
    @Published private(set) var isLoading = false
    /// Requested donations from StoreKit.
    @Published private(set) var donations: [CustomProduct] = []
    /// Purchasing state. View should indicate user is currently purchasing.
    @Published private(set) var isPurchasing = false

    private var storeKitDonations: [StoreKitDonation.ID: StoreKitDonation] = [:]
    private var purchasedIdentifiersToTimesPurchased: [String: Int] = [:]
    private var updateListenerTask: Task<Void, Never>?
    private var products: [Product] = []

    private override init() { }

    init(donations: [StoreKitDonation]) {
        super.init()

        self.storeKitDonations = donations
            .reduce([:], {
                var result = $0
                result[$1.id] = $1
                return result
            })
        self.updateListenerTask = listenForTransactions()
    }

    deinit {
        updateListenerTask?.cancel()
    }

    enum Errors: Error {
        case failedVerification
        case getProducts
        case purchaseError(causeError: Error?)
        case noTransactionMade
    }

    var hasDonations: Bool {
        !donations.isEmpty
    }

    var canMakePayments: Bool {
        SKPaymentQueue.canMakePayments() && (!isLoading || !isPurchasing)
    }

    func requestProducts() async -> Result<Void, Errors> {
        guard !hasDonations, !storeKitDonations.isEmpty else { return .success(()) }

        logger.info("requesting products")

        return await withLoading(completion: {
            let storeKitDonationsIDs = storeKitDonations
                .map(\.value.id)
            let products: [Product]
            do {
                products = try await Product.products(for: storeKitDonationsIDs)
            } catch {
                logger.error(label: "failed to get products", error: error)
                return .failure(.getProducts)
            }

            let donations = products
                .compactMap(productToCustomProduct)
                .sorted(by: \.weight, using: .orderedAscending)

            self.products = products
            await self.setDonations(donations)

            return .success(())
        })
    }

    @MainActor
    private func setDonations(_ donations: [CustomProduct]) {
        self.donations = donations
    }

    @MainActor
    private func withLoading<T>(completion: () async -> T) async -> T {
        isLoading = true
        let result = await completion()
        isLoading = false
        return result
    }

    private func productToCustomProduct(_ product: Product) -> CustomProduct? {
        let displayName = product.displayName

        guard !displayName.isEmpty,
              product.type == .consumable,
              let donationItem = storeKitDonations[product.id] else { return nil }

        return CustomProduct(
            id: product.id,
            emoji: donationItem.emoji,
            weight: donationItem.weight,
            displayName: displayName,
            displayPrice: product.displayPrice,
            price: product.price,
            description: product.description
        )
    }

    /// Update transactions regularly on a detached task for whenever the user makes a transaction outside of the app
    /// - Returns: a Task result that does not return anything and does not fail
    private func listenForTransactions() -> Task<Void, Never> {
        Task.detached { [weak self] in
            guard let self else { return }

            // Iterate through any transactions which didn't come from a direct call to `purchase()`.
            for await result in Transaction.updates {
                let transaction: Transaction
                switch self.checkVerified(result) {
                case let .failure(failure):
                    logger.error(label: "failed to verify transaction", error: failure)
                    continue
                case let .success(success):
                    transaction = success
                }

                await self.updatePurchasedIdentifiers(transaction)
                await transaction.finish()
            }
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) -> Result<T, Errors> {
        switch result {
        // StoreKit has parsed the JWS but failed verification. Don't deliver content to the user.
        case .unverified: return .failure(.failedVerification)
        // If the transaction is verified, unwrap and return it.
        case let .verified(safe): return .success(safe)
        }
    }

    private func updatePurchasedIdentifiers(_ transaction: Transaction) async {
        let productID = transaction.productID
        if transaction.revocationDate == nil {
            // If the App Store has not revoked the transaction, add it to the list of `purchasedIdentifiers`.
            incrementPurchasedIdentifiers(by: 1, toIdentifier: productID)
        } else {
            // If the App Store has revoked this transaction, remove it from the list of `purchasedIdentifiers`.
            incrementPurchasedIdentifiers(by: -1, toIdentifier: productID)
        }
    }

    private func incrementPurchasedIdentifiers(by increment: Int, toIdentifier identifier: String) {
        let value = purchasedIdentifiersToTimesPurchased[identifier] ?? 0
        if increment < 0, value < 1 {
            return
        }

        purchasedIdentifiersToTimesPurchased[identifier] = value + increment
    }
}
