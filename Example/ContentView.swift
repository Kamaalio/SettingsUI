//
//  ContentView.swift
//  Example
//
//  Created by Kamaal M Farah on 17/12/2022.
//

import SwiftUI
import SettingsUI

struct ContentView: View {
    @State private var appColor = appColors[2]
    @State private var features: [Feature] = [
        .init(id: UUID(uuidString: "1b833cc3-923c-427a-8288-e3d0ef557cc2")!, label: "Turn on music", isEnabled: false),
        .init(id: UUID(uuidString: "7c2fdfa5-f5eb-4304-b79a-89aaeccb4a56")!, label: "Fly away", isEnabled: true),
    ]

    var body: some View {
        NavigationStack {
            SettingsScreen(configuration: settingsConfiguration)
                .onAppColorChange(handleOnAppColorChange)
                .onFeatureChange(handleOnFeatureChange)
                #if os(macOS)
                .toolbar(content: {
                    Button(action: randomToolbarButtonAction) {
                        Label("Random toolbar button", systemImage: "person")
                            .foregroundColor(.accentColor)
                    }
                })
                #endif
        }
        .accentColor(appColor.color)
    }

    private var settingsConfiguration: SettingsConfiguration {
        SettingsConfiguration(
            donations: donations,
            feedback: .init(
                token: "GITHUB_TOKEN",
                username: "name",
                repoName: "Example"),
            color: .init(colors: appColors, currentColor: appColor),
            features: features,
            acknowledgements: acknowledgements)
    }

    #if os(macOS)
    private func randomToolbarButtonAction() { }
    #endif

    private func handleOnFeatureChange(_ feature: Feature) {
        guard let featureIndex = features.firstIndex(where: { $0.id == feature.id }) else { return }
        features[featureIndex] = feature
    }

    private func handleOnAppColorChange(_ appColor: AppColor) {
        self.appColor = appColor
    }
}

let acknowledgements = Acknowledgements(
    packages: [
        .init(name: "SettingsUI", url: URL(string: "https://github.com/kamaal111/SettingsUI")!, author: "kamaal111", license: .none),
        .init(name: "ShrimpExtensions", url: URL(string: "https://github.com/Kamaalio/ShrimpExtensions")!, author: "Kamaalio", license: .none),
    ],
    contributors: [
        .init(name: "Kamaal Farah", contributions: 420)
    ])

let donations: [StoreKitDonation] = [
    .init(id: "io.kamaal.Example.Carrot", emoji: "🥕", weight: 1),
    .init(id: "io.kamaal.Example.House", emoji: "🏡", weight: 20),
    .init(id: "io.kamaal.Example.Ship", emoji: "🚢", weight: 69),
]

let appColors: [AppColor] = [
    .init(id: UUID(uuidString: "1f6f9ac4-1ca6-4f77-880b-01580881a9b4")!, name: "Default", color: Color("AccentColor")),
    .init(id: UUID(uuidString: "57547f06-2d3e-4f3d-a639-59c13a5433bb")!, name: "Teal", color: .teal),
    .init(id: UUID(uuidString: "c5b39ff8-091a-4c46-a067-0bc5b1df4caf")!, name: "Purple", color: .purple),
    .init(id: UUID(uuidString: "1d2a4931-f1c2-42bf-b097-27908e1fa39a")!, name: "Green", color: .green),
    .init(id: UUID(uuidString: "7a664baf-b0ac-4764-86b4-3860773fe9c4")!, name: "Pink", color: .pink),
    .init(id: UUID(uuidString: "ab3aa7c5-c9e3-45a9-a2ef-f82603f11eab")!, name: "Orange", color: .orange),
    .init(id: UUID(uuidString: "0125142b-4a50-4f7f-b02c-a4963a6e4633")!, name: "Red", color: .red),
    .init(id: UUID(uuidString: "eb82e779-a7ba-4c75-a6e2-53d35332b940")!, name: "Blue", color: .blue),
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
