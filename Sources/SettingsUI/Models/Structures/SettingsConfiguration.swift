//
//  SettingsConfiguration.swift
//  
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import Foundation

public struct SettingsConfiguration: Hashable {
    public let donations: [StoreKitDonation]

    public init(donations: [StoreKitDonation]) {
        self.donations = donations
    }
}
