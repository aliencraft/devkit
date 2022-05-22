// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "devkit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "DevKit", targets: ["DevKit"]),
    ],
    targets: [
        .target(name: "DevKit", dependencies: [], path: "Sources"),
        .testTarget(name: "DevKitTests", dependencies: ["DevKit"], path: "Tests"),
    ]
)
