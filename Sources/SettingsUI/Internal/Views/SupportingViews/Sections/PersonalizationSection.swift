//
//  PersonalizationSection.swift
//
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import SwiftUI
import SalmonUI
import ShrimpExtensions

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
                NavigationLinkRow(destination: .appIcon) {
                    ValueRow(localizedLabel: "App icon", comment: "") {
                        #warning("Check if I can use Image row instead")
                        settingsConfiguration.appIcon!.currentIcon.image
                            .size(Constants.rowTileSize)
                            .cornerRadius(Constants.rowTileCornerRadius)
                    }
                }
            }
        }
    }
}

struct PersonalizationSection_Previews: PreviewProvider {
    static var previews: some View {
        PersonalizationSection()
    }
}
