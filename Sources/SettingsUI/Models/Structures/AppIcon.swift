//
//  AppIcon.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import SwiftUI

public struct AppIcon: Hashable, Identifiable {
    public let id: UUID
    public let name: String

    public init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }

    var image: Image {
        #if canImport(UIKit)
        guard let uiImage = UIImage(named: name) else {
            assertionFailure("Failed to find image")
            return Image(systemName: "photo")
        }

        return Image(uiImage: uiImage)
        #else
        guard let nsImage = NSImage(named: name) else {
            assertionFailure("Failed to find image")
            return Image(systemName: "photo")
        }

        return Image(nsImage: nsImage)
        #endif
    }
}
