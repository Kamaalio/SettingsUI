//
//  ExampleApp.swift
//  Example
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import SwiftUI

@main
struct ExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
            #if os(macOS)
                .frame(minWidth: 300, minHeight: 300)
            #endif
        }
    }
}
