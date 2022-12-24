//
//  AppIconScreen.swift
//  
//
//  Created by Kamaal M Farah on 24/12/2022.
//

import Logster
import SwiftUI
import SalmonUI

private let logger = Logster(from: AppIconScreen.self)

struct AppIconScreen: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        SelectionScreenWrapper(
            navigationTitle: "App icon".localized(comment: ""),
            sectionTitle: "Icons".localized(comment: ""),
            items: settingsConfiguration.appIcon?.icons ?? [],
            onItemPress: changeAppIcon) { item in
                ValueRow(label: item.title) {
                    item.image
                        .size(Constants.rowTileSize)
                        .cornerRadius(Constants.rowTileCornerRadius)
                }
            }
    }

    private func changeAppIcon(_ appIcon: AppIcon) {
        NotificationCenter.default.post(name: .appIconChanged, object: appIcon)
        logger.info("app icon changed to \(appIcon.title)")
        presentationMode.wrappedValue.dismiss()
    }
}

struct AppIconScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppIconScreen()
    }
}
