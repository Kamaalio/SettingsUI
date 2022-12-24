//
//  MiscellaneousSection.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import SwiftUI
import SalmonUI

struct MiscellaneousSection: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration

    var body: some View {
        KSection(header: "Miscellaneous".localized(comment: "")) {
            NavigationLinkImageRow(
                localizedLabel: "Logs",
                comment: "",
                imageSystemName: "newspaper.fill",
                destination: { LogsScreen().environment(\.settingsConfiguration, settingsConfiguration) })
        }
    }
}

struct MiscellaneousSection_Previews: PreviewProvider {
    static var previews: some View {
        MiscellaneousSection()
    }
}
