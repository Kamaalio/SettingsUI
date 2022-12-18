//
//  NavigationLinkImageRow.swift
//  
//
//  Created by Kamaal M Farah on 18/12/2022.
//

import SwiftUI

struct NavigationLinkImageRow<Destination: View>: View {
    let label: String
    let imageSystemName: String
    let destination: Destination

    init(label: String, imageSystemName: String, @ViewBuilder destination: () -> Destination) {
        self.label = label
        self.imageSystemName = imageSystemName
        self.destination = destination()
    }

    init(
        localizedLabel: String,
        comment: String,
        imageSystemName: String,
        @ViewBuilder destination: () -> Destination) {
            self.init(
                label: localizedLabel.localized(comment: comment),
                imageSystemName: imageSystemName,
                destination: destination)
        }

    var body: some View {
        NavigationLinkRow(destination: { destination }) {
            ImageTextRow(label: label, imageSystemName: imageSystemName)
        }
    }
}

struct NavigationLinkImageRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkImageRow(label: "Label", imageSystemName: "person", destination: { Text("Destination") })
    }
}
