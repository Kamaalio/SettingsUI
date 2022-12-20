//
//  SettingsConfiguration.swift
//  
//
//  Created by Kamaal M Farah on 20/12/2022.
//

import SwiftUI

public struct SettingsConfiguration: Hashable {
    public let donations: [StoreKitDonation]
    public let gitHubToken: String?

    public init(donations: [StoreKitDonation], gitHubToken: String? = nil) {
        self.donations = donations
        self.gitHubToken = gitHubToken
    }
}

extension EnvironmentValues {
    var settingsConfiguration: SettingsConfiguration {
        get { self[SettingsConfigurationKey.self] }
        set { self[SettingsConfigurationKey.self] = newValue }
    }
}

struct SettingsConfigurationKey: EnvironmentKey {
    static let defaultValue: SettingsConfiguration = SettingsConfiguration(donations: [], gitHubToken: nil)
}
