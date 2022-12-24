//
//  CustomProduct.swift
//  
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import Foundation

struct CustomProduct: Hashable, Identifiable {
    let id: String
    let emoji: Character
    let weight: Int
    let displayName: String
    let displayPrice: String
    let price: Decimal
    let description: String

    static let carrot = CustomProduct(
        id: "io.kamaal.SettingsUI.Carrot",
        emoji: "🥕",
        weight: 1,
        displayName: "Carrot",
        displayPrice: "$420.69",
        price: 420.69,
        description: "Carrots are good for the eyes")
}
