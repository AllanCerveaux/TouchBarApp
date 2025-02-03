// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "TouchBarApp",
    platforms: [
        .macOS(.v11)
    ],
    targets: [
        .executableTarget(
            name: "TouchBarApp",
            dependencies: [],
            path: "Sources/TouchBarApp",
            cSettings: [
                .headerSearchPath("Utils")
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-import-objc-header",
                    "Sources/TouchBarApp/Utils/TouchBarApp-Bridging-Header.h"
                ])
            ]
        )
    ]
)
