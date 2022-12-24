//
//  StoreKitDonation.swift
//
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import Foundation
import ShrimpExtensions

public struct StoreKitDonation: Hashable, Identifiable, Codable {
    public let id: String
    public let emoji: String
    public let weight: Int

    public init(id: String, emoji: Character, weight: Int) {
        self.id = id
        self.emoji = emoji.string
        self.weight = weight
    }

    var emojiCharacter: Character {
        emoji.first!
    }
}
