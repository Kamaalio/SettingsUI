//
//  StoreKitDonation.swift
//  
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import Foundation

public struct StoreKitDonation: Hashable, Identifiable {
    public let id: String
    public let emoji: String
    public let weight: Int

    public init(id: String, emoji: String, weight: Int) {
        self.id = id
        self.emoji = emoji
        self.weight = weight
    }
}
