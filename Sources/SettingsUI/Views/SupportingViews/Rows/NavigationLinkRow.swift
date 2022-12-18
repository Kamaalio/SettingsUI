//
//  NavigationLinkRow.swift
//  
//
//  Created by Kamaal M Farah on 18/12/2022.
//

import SwiftUI
import SalmonUI

struct NavigationLinkRow<Value: View, Destination: View>: View {
    let destination: Destination
    let value: Value

    init(@ViewBuilder destination: () -> Destination, @ViewBuilder value: () -> Value) {
        self.destination = destination()
        self.value = value()
    }

    var body: some View {
        NavigationLink(destination: { destination }) {
            value
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

struct NavigationLinkRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkRow(destination: { Text("Destination") }, value: { Text("Value") })
    }
}
