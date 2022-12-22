//
//  AppColor.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import SwiftUI
import Logster

private let logger = Logster(from: AppColor.self)

public struct AppColor: Hashable, Codable {
    public let name: String
    private let _color: Data
    private let archiveKey: String

    public init(color: Color, name: String) {
        #if canImport(UIKit)
        let color = UIColor(color)
        #else
        let color = NSColor(color)
        #endif

        let archiver = NSKeyedArchiver(requiringSecureCoding: false)
        let archiveKey = "io.kamaal.SettingsUI.AppColor.archive.\(name)"
        archiver.encode(color, forKey: archiveKey)

        self.init(color: archiver.encodedData, name: name, archiveKey: archiveKey)
    }

    init(color: Data, name: String, archiveKey: String) {
        self._color = color
        self.name = name
        self.archiveKey = archiveKey
    }

    public lazy var color: Color? = {
        let unarchiver: NSKeyedUnarchiver
        do {
            unarchiver = try NSKeyedUnarchiver(forReadingFrom: _color)
        } catch {
            logger.error(label: "failed to unarchive app color with key \(archiveKey)", error: error)
            return nil
        }

        unarchiver.requiresSecureCoding = false
        #if canImport(UIKit)
        guard let archivedColor = unarchiver.decodeObject(forKey: archiveKey) as? UIColor else { return nil }
        let color = Color(uiColor: archivedColor)
        #else
        guard let archivedColor = unarchiver.decodeObject(forKey: archiveKey) as? NSColor else { return nil }
        let color = Color(nsColor: archivedColor)
        #endif

        unarchiver.finishDecoding()

        return color
    }()
}
