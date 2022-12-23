//
//  AppButton.swift
//  
//
//  Created by Kamaal M Farah on 18/12/2022.
//

import SwiftUI
import SalmonUI

struct AppButton<Content: View>: View {
    let action: () -> Void
    let content: Content

    init(action: @escaping () -> Void, @ViewBuilder content: () -> Content) {
        self.action = action
        self.content = content()
    }

    var body: some View {
        Button(action: action) {
            content
                .foregroundColor(.accentColor)
                #if os(macOS)
                // Hack: need the following 2 lines to be fully clickable on macOS
                .ktakeWidthEagerly()
                .background(Color(nsColor: .separatorColor).opacity(0.01))
                #endif
        }
        .buttonStyle(.plain)
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(action: { }) {
            Text("Content")
        }
    }
}
