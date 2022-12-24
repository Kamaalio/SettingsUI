//
//  NavigationLinkColorRow.swift
//
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import SwiftUI

struct NavigationLinkColorRow<Destination: View>: View {
    let label: String
    let color: Color
    let destination: Destination

    init(label: String, color: Color, @ViewBuilder destination: () -> Destination) {
        self.label = label
        self.color = color
        self.destination = destination()
    }

    init(localizedLabel: String, comment: String, color: Color, @ViewBuilder destination: () -> Destination) {
        self.init(label: localizedLabel.localized(comment: comment), color: color, destination: destination)
    }

    var body: some View {
        NavigationLinkRow(destination: { destination }) {
            ColorTextRow(label: label, color: color)
        }
    }
}

struct NavigationLinkColorRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkColorRow(label: "Label", color: .accentColor, destination: { Text("Destination") })
    }
}
