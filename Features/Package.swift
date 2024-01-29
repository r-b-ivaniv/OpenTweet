// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Features",
            targets: ["Timeline"]
        )
    ],
    dependencies: [
        .package(path: "../Frameworks"),
        .package(url: "https://github.com/layoutBox/PinLayout.git", branch: "master")
    ],
    targets: [
        .target(
            name: "Timeline",
            dependencies: [
                "PinLayout", "Frameworks"
            ],
            resources: [.copy("Files")]
        ),
        .testTarget(
            name: "TimelineTests",
            dependencies: ["Timeline"]
        )
    ]
)
