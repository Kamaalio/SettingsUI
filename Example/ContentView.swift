//
//  ContentView.swift
//  Example
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import SwiftUI
import SettingsUI

struct ContentView: View {
    @State private var iCloudSyncingIsEnabled = false

    var body: some View {
        SettingsScreen(iCloudSyncingIsEnabled: $iCloudSyncingIsEnabled, configuration: SettingsConfiguration(donations: []))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
