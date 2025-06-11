// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MapsIndoors-SwitchingPositionProvider",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SwitchingPositionProvider",
            targets: ["SwitchingPositionProvider"]),
    ],
    dependencies: [
        .package(url: "https://github.com/MapsPeople/mapsindoors-core-ios.git", .upToNextMajor(from: "4.10.0")),
    ],
    targets: [
        .target(
            name: "SwitchingPositionProvider",
            dependencies: [
                .product(name: "MapsIndoorsCore", package: "mapsindoors-core-ios"),
            ]),
        .testTarget(
            name: "SwitchingPositionProviderTests",
            dependencies: ["SwitchingPositionProvider"]
        ),
    ]
)
