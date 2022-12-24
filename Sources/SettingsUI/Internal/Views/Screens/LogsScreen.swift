//
//  LogsScreen.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import Logster
import SwiftUI
import SalmonUI

struct LogsScreen: View {
    @Environment(\.settingsConfiguration) private var settingsConfiguration: SettingsConfiguration

    @State private var logs: [HoldedLog] = []
    @State private var selectedLog: HoldedLog?
    @State private var showSelectedLogSheet = false
    @State private var screenToShow: Screens?
    @State private var bugDescription = ""

    private enum Screens: Hashable {
        case feedback
    }

    var body: some View {
        ZStack {
            NavigationLink(
                tag: Screens.feedback,
                selection: $screenToShow,
                destination: {
                    FeedbackScreen(style: .bug, description: bugDescription)
                        .environment(\.settingsConfiguration, settingsConfiguration)
                },
                label: { Text("") })
            .buttonStyle(.plain)
            KScrollableForm {
                KSection {
                    ForEach(logs, id: \.self) { item in
                        LogRow(log: item, action: onLogPress)
                        #if os(macOS)
                        if item != logs.last {
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
        }
        .navigationTitle(localizedTitle: "Logs", comment: "", displayMode: .inline)
        .onAppear(perform: handleOnAppear)
        .onChange(of: showSelectedLogSheet, perform: onShowSelectedLogSheetChange)
        .sheet(isPresented: $showSelectedLogSheet, content: {
            LogDetailsSheet(log: selectedLog, close: closeSheet, reportBug: reportBug)
                .accentColor(settingsConfiguration.currentColor)
        })
    }

    private func closeSheet() {
        showSelectedLogSheet = false
    }

    private func reportBug(_ log: HoldedLog) {
        closeSheet()

        let predefinedDescription = """
        # Reported log

        label: \(log.label)
        type: \(log.type.rawValue)
        message: \(log.message)


        """

        bugDescription = predefinedDescription
        screenToShow = .feedback
    }

    private func onShowSelectedLogSheetChange(_ newValue: Bool) {
        if !newValue {
            selectedLog = .none
        }
    }

    private func handleOnAppear() {
        Task {
            logs = await LogHolder.shared.logs.reversed()
        }
    }

    private func onLogPress(_ log: HoldedLog) {
        selectedLog = log
        showSelectedLogSheet = true
    }
}

struct LogsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogsScreen()
    }
}
