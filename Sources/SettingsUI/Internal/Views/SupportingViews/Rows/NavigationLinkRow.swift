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
                .invisibleFill()
        }
        .buttonStyle(.plain)
    }
}

struct NavigationLinkRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkRow(destination: { Text("Destination") }, value: { Text("Value") })
    }
}
