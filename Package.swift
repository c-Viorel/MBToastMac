// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "MBToastMac",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v5)
    ],
    products: [
        .library(
            name: "MBToastMac",
            targets: ["MBToastMac"]),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "MBToastMac",
            dependencies: [ ],
            path: "MBToastMac/Classes")
    ],
    swiftLanguageVersions: [.v5]
)
