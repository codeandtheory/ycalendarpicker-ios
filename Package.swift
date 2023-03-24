// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "YCalendarPicker",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "YCalendarPicker",
            targets: ["YCalendarPicker"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/yml-org/YCoreUI.git",
            from: "1.5.0"
        ),
        .package(
            url: "https://github.com/yml-org/YMatterType.git",
            from: "1.6.0"
        )
    ],
    targets: [
        .target(
            name: "YCalendarPicker",
            dependencies: ["YCoreUI", "YMatterType"],
            resources: [.process("Assets")]
        ),
        .testTarget(
            name: "YCalendarPickerTests",
            dependencies: ["YCalendarPicker"]
        )
    ]
)
