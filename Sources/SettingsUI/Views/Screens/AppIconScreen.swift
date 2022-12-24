//
//  AppIconScreen.swift
//  
//
//  Created by Kamaal M Farah on 24/12/2022.
//

import SwiftUI
import SalmonUI

struct AppIconScreen: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration

    var body: some View {
        KScrollableForm {
            Text("Hello, World!")
        }
        .navigationTitle(localizedTitle: "App icon", comment: "", displayMode: .inline)
        .accentColor(settingsConfiguration.currentColor)
    }
}

struct AppIconScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppIconScreen()
    }
}
