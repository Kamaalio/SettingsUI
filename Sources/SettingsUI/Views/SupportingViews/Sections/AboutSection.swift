//
//  AboutSection.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import SwiftUI
import SalmonUI

struct AboutSection: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration

    let versionText: String?
    let buildNumber: String?

    var body: some View {
        KSection(header: "About".localized(comment: "")) {
            if settingsConfiguration.acknowledgementsAreConfigured {
                NavigationLinkImageRow(
                    localizedLabel: "Acknowledgements",
                    comment: "",
                    imageSystemName: "medal.fill",
                    destination: {
                        AcknowledgementsScreen()
                            .environment(\.settingsConfiguration, settingsConfiguration)
                    })
                #if os(macOS)
                Divider()
                #endif
            }
            if let versionText {
                ValueRow(localizedLabel: "Version", comment: "") {
                    AppText(string: versionText)
                    if let buildNumber {
                        AppText(string: buildNumber)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

struct AboutSection_Previews: PreviewProvider {
    static var previews: some View {
        AboutSection(versionText: "1.0.0", buildNumber: "420")
    }
}
