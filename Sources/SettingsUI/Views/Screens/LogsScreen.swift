//
//  LogsScreen.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import SwiftUI
import SalmonUI

struct LogsScreen: View {
    var body: some View {
        KScrollableForm {
            KSection {
                Text("Hello, World!")
            }
            #if os(macOS)
            .padding(.all, .medium)
            #endif
        }
        .ktakeSizeEagerly(alignment: .topLeading)
        .navigationTitle(localizedTitle: "Logs", comment: "", displayMode: .inline)
    }
}

struct LogsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LogsScreen()
    }
}
