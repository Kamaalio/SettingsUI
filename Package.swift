// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SettingsUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(name: "SettingsUI", targets: ["SettingsUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Kamaalio/Logster.git", "1.1.0" ..< "2.0.0"),
        .package(url: "https://github.com/Kamaalio/SalmonUI.git", "5.1.0" ..< "6.0.0"),
        .package(url: "https://github.com/Kamaalio/ShrimpExtensions.git", "3.0.0" ..< "4.0.0"),
        .package(url: "https://github.com/Kamaalio/PopperUp.git", "0.4.1" ..< "0.5.0"),
        .package(url: "https://github.com/Kamaalio/InAppBrowserSUI.git", "2.1.0" ..< "3.0.0"),
        .package(url: "https://github.com/kamaal111/GitHubAPI.git", "0.1.2" ..< "0.2.0"),
        .package(url: "https://github.com/simibac/ConfettiSwiftUI.git", "1.0.0" ..< "2.0.0"),
    ],
    targets: [
        .target(
            name: "SettingsUI",
            dependencies: [
                "Logster",
                "SalmonUI",
                "ShrimpExtensions",
                "ConfettiSwiftUI",
                "PopperUp",
                "GitHubAPI",
                "InAppBrowserSUI",
            ],
            resources: [
                .process("Internal/Resources"),
            ]
        ),
        .testTarget(
            name: "SettingsUITests",
            dependencies: ["SettingsUI"]
        ),
    ]
)
