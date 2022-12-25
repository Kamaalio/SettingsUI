//
//  PersonalizationSection.swift
//
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import SwiftUI
import SalmonUI

struct PersonalizationSection: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration

    var body: some View {
        KSection(header: "Personalization".localized(comment: "")) {
            if settingsConfiguration.colorsIsConfigured {
                NavigationLinkColorRow(
                    localizedLabel: "App colors",
                    comment: "",
                    color: .accentColor,
                    destination: .appColor
                )
                #if os(macOS)
                if settingsConfiguration.appIconIsConfigured {
                    Divider()
                }
                #endif
            }
            if settingsConfiguration.appIconIsConfigured {
                NavigationLinkImageRow(
                    localizedLabel: "App icon",
                    comment: "",
                    imageName: settingsConfiguration.appIcon!.currentIcon.imageName,
                    destination: .appIcon
                )
            }
        }
    }
}

struct PersonalizationSection_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationSection()
    }
}
