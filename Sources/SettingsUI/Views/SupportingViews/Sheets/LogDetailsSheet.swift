//
//  LogDetailsSheet.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import Logster
import SwiftUI
import SalmonUI

struct LogDetailsSheet: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    let log: HoldedLog?
    let close: () -> Void
    let reportBug: (_ log: HoldedLog) -> Void

    var body: some View {
        KSheetStack(
            title: "Logs".localized(comment: ""),
            leadingNavigationButton: {
                Button(action: close) {
                    AppText(localizedString: "Close", comment: "")
                        .bold()
                        .foregroundColor(.accentColor)
                }
            },
            trailingNavigationButton: { Text("") },
            content: {
                VStack(alignment: .leading) {
                    if let log {
                        AppText(string: log.label)
                            .font(.headline)
                            .foregroundColor(log.type.color)
                        AppText(string: log.message)
                            .foregroundColor(.primary)

                        if [HoldedLog.LogTypes.error, .warning].contains(log.type) {
                            AppButton(action: { reportBug(log) }) {
                                HStack {
                                    Image(systemName: "ant")
                                        .foregroundColor(colorScheme == .dark ? .black : .white)
                                    AppText(localizedString: "Report bug", comment: "")
                                        .bold()
                                        .foregroundColor(colorScheme == .dark ? .black : .white)
                                }
                                .padding(.vertical, .small)
                                .ktakeWidthEagerly()
                                .background(log.type.color)
                                .cornerRadius(.small)
                            }
                        }
                    }
                }
                .padding(.vertical, .medium)
            })
        .frame(minWidth: 300, minHeight: 200, alignment: .topLeading)
    }
}

struct LogDetailsSheet_Previews: PreviewProvider {
    static var previews: some View {
        LogDetailsSheet(
            log: .init(label: "LogDetails", type: .error, message: "Message", timestamp: .distantFuture),
            close: { },
            reportBug: { _ in })
    }
}
