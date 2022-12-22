//
//  AppColorTests.swift
//  
//
//  Created by Kamaal M Farah on 22/12/2022.
//

import XCTest
import SwiftUI
import SettingsUI

final class AppColorTests: XCTestCase {
    func testColorEncodesAndDecodesOnInitialization() throws {
        var cases = [
            (Color(red: 100 / 255, green: 20 / 255, blue: 255 / 255), "Some Color"),
            (Color(red: 100 / 255, green: 200 / 255, blue: 0 / 255), "Other Color"),
            (Color(red: 50 / 255, green: 200 / 255, blue: 0 / 255), "Other Color"),
        ]
        #if canImport(UIKit)
        cases.append((Color(uiColor: .red), "Red"))
        #else
        cases.append((Color(nsColor: .red), "Red"))
        #endif
        for (color, name) in cases {
            var result = AppColor(color: color, name: name)
            let decodedColor = try XCTUnwrap(result.color?.hex)
            XCTAssertEqual(decodedColor, color.hex)
            XCTAssertEqual(decodedColor, result.color!.hex)
        }
    }
}

extension Color {
    var hex: String? {
        guard let components = cgColor?.components, components.count >= 3 else { return nil }

        let red = components[0]
        let green = components[1]
        let blue = components[2]

        return String(format: "%02lX%02lX%02lX", lround(red * 255), lround(green * 255), lround(blue * 255))
    }
}
