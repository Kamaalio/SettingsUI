//
//  NavigationLinkImageRow.swift
//  
//
//  Created by Kamaal M Farah on 18/12/2022.
//

import SwiftUI

struct NavigationLinkImageRow<Destination: View>: View {
    let label: String
    let imageName: String
    let destination: Destination
    private let imageType: ImageType

    init(label: String, imageSystemName: String, @ViewBuilder destination: () -> Destination) {
        self.label = label
        self.imageName = imageSystemName
        self.imageType = .systemName
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

    init(label: String, imageName: String, @ViewBuilder destination: () -> Destination) {
        self.label = label
        self.imageName = imageName
        self.imageType = .name
        self.destination = destination()
    }

    init(
        localizedLabel: String,
        comment: String,
        imageName: String,
        @ViewBuilder destination: () -> Destination) {
            self.init(
                label: localizedLabel.localized(comment: comment),
                imageName: imageName,
                destination: destination)
        }

    private enum ImageType {
        case systemName
        case name
    }

    var body: some View {
        NavigationLinkRow(destination: { destination }) {
            switch imageType {
            case .systemName:
                ImageTextRow(label: label, imageSystemName: imageName)
            case .name:
                ImageTextRow(label: label, imageName: imageName)
            }
        }
    }
}

struct NavigationLinkImageRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkImageRow(label: "Label", imageSystemName: "person", destination: { Text("Destination") })
    }
}
