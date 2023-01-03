//
//  PreferencesSection.swift
//
//
//  Created by Kamaal M Farah on 03/01/2023.
//

import Logster
import SwiftUI
import SalmonUI

private let logger = Logster(from: PreferencesSection.self)

struct PreferencesSection: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration

    var body: some View {
        KSection(header: "Preferences".localized(comment: "")) {
            ForEach(settingsConfiguration.preferences) { preference in
                PreferenceRow(preference: preference, onChange: onPreferenceChange)
            }
        }
    }

    private func onPreferenceChange(_ newPreference: Preference) {
        NotificationCenter.default.post(name: .preferenceChanged, object: newPreference)
        logger.info("preference changed to \(newPreference)")
    }
}

struct PreferencesSection_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesSection()
    }
}
