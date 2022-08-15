// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "AnkiSwift",
    platforms: [.macOS(.v12)],
    products: [
        .library(name: "AnkiSwift", targets: ["AnkiSwift"]),
    ],
    targets: [
        .target(name: "AnkiSwift"),
        .testTarget(name: "AnkiSwiftTests", dependencies: ["AnkiSwift"]),
    ]
)
