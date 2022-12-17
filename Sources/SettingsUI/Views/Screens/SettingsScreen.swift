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
            Text("Hello, World!")
        }
        .onAppear(perform: handleOnAppear)
        #if os(macOS)
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
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
