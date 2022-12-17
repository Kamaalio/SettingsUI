//
//  CustomProduct.swift
//  
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import Foundation

struct CustomProduct: Hashable, Identifiable {
    let id: String
    let emoji: String
    let weight: Int
    let displayName: String
    let displayPrice: String
    let price: Decimal
    let description: String
}
