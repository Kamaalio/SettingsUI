//
//  SettingsScreen.swift
//  
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import SwiftUI
import SalmonUI

public struct SettingsScreen: View {
    @StateObject private var store: Store

    let configuration: SettingsConfiguration

    public init(configuration: SettingsConfiguration) {
        self._store = StateObject(wrappedValue: Store(donations: configuration.donations))
        self.configuration = configuration
    }

    public var body: some View {
        KScrollableForm {
            if configuration.donationsIsConfigured && store.hasDonations {
                SupportAuthorSection()
                    .environmentObject(store)
            }
            if configuration.feedbackIsConfigured {
                FeedbackSection()
            }
            if configuration.colorsIsConfigured {
                PersonalizationSection()
            }
            if configuration.featuresIsConfigured {
                FeaturesSection()
            }
            MiscellaneousSection()
        }
        .accentColor(configuration.currentColor)
        .onAppear(perform: handleOnAppear)
        .navigationTitle(localizedTitle: "Settings", comment: "", displayMode: .large)
        .environment(\.settingsConfiguration, configuration)
        #if os(macOS)
        .padding(.all, .medium)
        .ktakeSizeEagerly(alignment: .topLeading)
        #endif
    }

    private func handleOnAppear() {
        Task {
            _ = try? await store.requestProducts().get()
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(configuration: SettingsConfiguration(donations: []))
    }
}
