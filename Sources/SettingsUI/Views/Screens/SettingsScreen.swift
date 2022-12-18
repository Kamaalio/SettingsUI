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

    @Binding public var iCloudSyncingIsEnabled: Bool

    public init(iCloudSyncingIsEnabled: Binding<Bool>, configuration: SettingsConfiguration) {
        self._iCloudSyncingIsEnabled = iCloudSyncingIsEnabled
        self._store = StateObject(wrappedValue: Store(donations: []))
    }

    public var body: some View {
        KScrollableForm {
            if store.hasDonations {
                SupportAuthorSection()
                    .environmentObject(store)
            }
        }
        .onAppear(perform: handleOnAppear)
        .navigationTitle(localizedTitle: "Settings", comment: "", displayMode: .large)
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
        SettingsScreen(iCloudSyncingIsEnabled: .constant(false), configuration: SettingsConfiguration(donations: []))
    }
}
