//
//  SettingsConfiguration.swift
//  
//
//  Created by Kamaal M Farah on 20/12/2022.
//

import SwiftUI

public struct SettingsConfiguration: Hashable {
    public let donations: [StoreKitDonation]
    public let feedback: Feedback?

    public init(donations: [StoreKitDonation], feedback: Feedback? = nil) {
        self.donations = donations
        self.feedback = feedback
    }

    public struct Feedback: Hashable {
        public let token: String
        public let username: String
        public let repoName: String
        public let additionalLabels: [String]
        public let additionalData: Data?

        public init(
            token: String,
            username: String,
            repoName: String,
            additionalLabels: [String] = [],
            additionalData: Data? = nil) {
                self.token = token
                self.username = username
                self.repoName = repoName
                self.additionalLabels = additionalLabels
                self.additionalData = additionalData
            }

        var additionalDataString: String? {
            guard let additionalData else { return nil }

            return String(data: additionalData, encoding: .utf8)
        }
    }
}

extension EnvironmentValues {
    var settingsConfiguration: SettingsConfiguration {
        get { self[SettingsConfigurationKey.self] }
        set { self[SettingsConfigurationKey.self] = newValue }
    }
}

struct SettingsConfigurationKey: EnvironmentKey {
    static let defaultValue: SettingsConfiguration = SettingsConfiguration(donations: [], feedback: nil)
}
