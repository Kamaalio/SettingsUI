//
//  AppColorScreen.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import Logster
import SwiftUI
import SalmonUI

private let logger = Logster(from: AppColorScreen.self)

struct SelectionScreen<Row: View>: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    let navigationTitle: String
    let sectionTitle: String
    let row: Row

    init(navigationTitle: String, sectionTitle: String, @ViewBuilder row: @escaping () -> Row) {
        self.navigationTitle = navigationTitle
        self.sectionTitle = sectionTitle
        self.row = row()
    }

    var body: some View {
        KScrollableForm {
            KSection(header: sectionTitle) {
                row
            }
        }
        .ktakeSizeEagerly(alignment: .topLeading)
        .navigationTitle(title: navigationTitle, displayMode: .inline)
        .accentColor(settingsConfiguration.currentColor)
    }
}

struct AppColorScreen: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        KScrollableForm {
            KSection(header: "Colors".localized(comment: "")) {
                ForEach(colors) { appColor in
                    AppButton(action: { changeAppColor(appColor) }) {
                        ColorTextRow(label: appColor.name, color: appColor.color)
                    }
                    #if os(macOS)
                    if appColor != colors.last {
                        Divider()
                    }
                    #endif
                }
            }
            #if os(macOS)
            .padding(.all, .medium)
            #endif
        }
        .ktakeSizeEagerly(alignment: .topLeading)
        .navigationTitle(localizedTitle: "App colors", comment: "", displayMode: .inline)
        .accentColor(settingsConfiguration.currentColor)
    }

    private var colors: [AppColor] {
        settingsConfiguration.color?.colors ?? []
    }

    private func changeAppColor(_ appColor: AppColor) {
        NotificationCenter.default.post(name: .appColorChanged, object: appColor)
        logger.info("app color changed to \(appColor)")
        presentationMode.wrappedValue.dismiss()
    }
}

struct AppColorScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppColorScreen()
    }
}
