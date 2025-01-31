// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Frameworks",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Frameworks",
            targets: ["ExtensionsKit", "CoreModule"]
        )
    ],
    targets: [
        .target(
            name: "ExtensionsKit"
        ),
        .target(
            name: "CoreModule"
        )
    ]
)
