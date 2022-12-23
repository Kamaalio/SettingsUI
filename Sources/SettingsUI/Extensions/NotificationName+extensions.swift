//
//  NotificationName+extensions.swift
//  
//
//  Created by Kamaal M Farah on 23/12/2022.
//

import Foundation

extension Notification.Name {
    public static let appColorChanged = makeNotificationName(withKey: "app_color_changed")
    public static let featureChanged = makeNotificationName(withKey: "feature_changed")

    private static func makeNotificationName(withKey key: String) -> Notification.Name {
        Notification.Name("io.kamaal.SettingsUI.notifications.\(key)")
    }
}
