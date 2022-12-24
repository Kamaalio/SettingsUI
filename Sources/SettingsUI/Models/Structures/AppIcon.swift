//
//  AppIcon.swift
//
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import SwiftUI

public struct AppIcon: Hashable, Identifiable, Codable {
    public let id: UUID
    public let imageName: String
    public let title: String

    public init(id: UUID, imageName: String, title: String) {
        self.id = id
        self.imageName = imageName
        self.title = title
    }

    var image: Image {
        guard let image = safeImage else {
            assertionFailure("Failed to find image")
            return Image(systemName: "photo")
        }

        return image
    }

    private var safeImage: Image? {
        #if canImport(UIKit)
        guard let uiImage = UIImage(named: imageName, in: .main, with: .none) else { return nil }

        return Image(uiImage: uiImage)
        #else
        guard let nsImage = NSImage(named: imageName) else { return nil }

        return Image(nsImage: nsImage)
        #endif
    }
}
