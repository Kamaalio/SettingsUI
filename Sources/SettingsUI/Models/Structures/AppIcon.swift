//
//  AppIcon.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import SwiftUI

public struct AppIcon: Hashable, Identifiable {
    public let id: UUID
    public let imageName: String
    public let title: String

    public init(id: UUID, imageName: String, title: String) {
        self.id = id
        self.imageName = imageName
        self.title = title
    }

    var image: Image {
        #if canImport(UIKit)
        guard let uiImage = UIImage(named: imageName) else {
            assertionFailure("Failed to find image")
            return Image(systemName: "photo")
        }

        return Image(uiImage: uiImage)
        #else
        guard let nsImage = NSImage(named: imageName) else {
            assertionFailure("Failed to find image")
            return Image(systemName: "photo")
        }

        return Image(nsImage: nsImage)
        #endif
    }
}
