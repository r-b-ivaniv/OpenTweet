// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Features",
            targets: ["Timeline"]),
    ],
    targets: [
        .target(
            name: "Timeline"),
        .testTarget(
            name: "TimelineTests",
            dependencies: ["Timeline"]),
    ]
)
