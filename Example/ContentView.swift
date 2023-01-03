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
    @State private var appIcon = appIcons[0]
    @State private var selectedLanguageOption = languageOptions[0]

    var body: some View {
        NavigationView {
            if shouldHaveASidebar {
                List {
                    Text("Sidbar")
                }
            }
            SettingsScreen(configuration: settingsConfiguration)
                .onAppColorChange(handleOnAppColorChange)
                .onFeatureChange(handleOnFeatureChange)
                .onAppIconChange(handleOnAppIconChange)
                .onSettingsPreferenceChange(handlePreferenceChange)
            #if os(macOS)
                .toolbar(content: {
                    Button(action: randomToolbarButtonAction) {
                        Label("Random toolbar button", systemImage: "person")
                            .foregroundColor(.accentColor)
                    }
                })
            #endif
        }
        .navigationStyle(shouldHaveASidebar ? .columns : .stack)
        .accentColor(appColor.color)
    }

    private var shouldHaveASidebar: Bool {
        #if os(macOS)
        return true
        #else
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true
        }
        return false
        #endif
    }

    private var settingsConfiguration: SettingsConfiguration {
        SettingsConfiguration(
            donations: donations,
            feedback: .init(
                token: "GITHUB_TOKEN",
                username: "name",
                repoName: "Example"
            ),
            color: .init(colors: appColors, currentColor: appColor),
            features: features,
            acknowledgements: acknowledgements,
            appIcon: .init(icons: appIcons, currentIcon: appIcon),
            preferences: preferences
        )
    }

    var preferences: [Preference] {
        [
            .init(
                id: UUID(uuidString: "66971130-a466-44cc-83f6-4759b51e7789")!,
                label: "Language",
                selectedOption: selectedLanguageOption,
                options: languageOptions
            ),
        ]
    }

    #if os(macOS)
    private func randomToolbarButtonAction() { }
    #endif

    private func handlePreferenceChange(_ preference: Preference) {
        selectedLanguageOption = preference.selectedOption
    }

    private func handleOnAppIconChange(_ appIcon: AppIcon) {
        self.appIcon = appIcon
    }

    private func handleOnFeatureChange(_ feature: Feature) {
        guard let featureIndex = features.firstIndex(where: { $0.id == feature.id }) else { return }
        features[featureIndex] = feature
    }

    private func handleOnAppColorChange(_ appColor: AppColor) {
        self.appColor = appColor
    }
}

let languageOptions: [Preference.Option] = [
    .init(id: UUID(uuidString: "067fb9e5-af94-4425-965b-ebd70e7f9e56")!, label: "English"),
    .init(id: UUID(uuidString: "37c735d7-0804-469b-9219-ece30b0cbe4a")!, label: "Dutch"),
]

let appIcons: [AppIcon] = [
    .init(id: UUID(uuidString: "5a1b8fe3-a26d-46a8-b8ee-fa88d05de549")!, imageName: "AppIcon", title: "Default"),
    .init(
        id: UUID(uuidString: "789b4334-867d-4fa1-a0e8-a92ad757f89a")!,
        imageName: "AlternateAppIcon",
        title: "Alternate"
    ),
]

let acknowledgements = Acknowledgements(
    packages: [
        .init(
            name: "SettingsUI",
            url: URL(string: "https://github.com/kamaal111/SettingsUI")!,
            author: "kamaal111",
            license: .none
        ),
        .init(
            name: "ShrimpExtensions",
            url: URL(string: "https://github.com/Kamaalio/ShrimpExtensions")!,
            author: "Kamaalio",
            license: .none
        ),
    ],
    contributors: [
        .init(name: "Kamaal Farah", contributions: 420),
    ]
)

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

extension NavigationView {
    func navigationStyle(_ style: Style) -> some View {
        #if os(macOS)
        self
        #else
        ZStack {
            switch style {
            case .columns:
                self
                    .navigationViewStyle(.columns)
            case .stack:
                self
                    .navigationViewStyle(.stack)
            }
        }
        #endif
    }

    enum Style {
        case columns
        case stack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
