//
//  LogRow.swift
//
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import Logster
import SwiftUI
import SalmonUI

struct LogRow: View {
    let log: HoldedLog
    let action: (_ log: HoldedLog) -> Void

    var body: some View {
        AppButton(action: { action(log) }) {
            HStack(alignment: .top, spacing: 8) {
                Text(log.label)
                    .foregroundColor(log.type.color)
                Text(log.message)
                    .foregroundColor(.primary)
                    .lineLimit(1)
            }
            .ktakeWidthEagerly(alignment: .leading)
        }
    }
}

struct LogRow_Previews: PreviewProvider {
    static var previews: some View {
        LogRow(
            log: .init(label: "LogRow", type: .info, message: "Preview", timestamp: Date.distantPast),
            action: { _ in }
        )
    }
}
