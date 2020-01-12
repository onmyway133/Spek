// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Spek",
    platforms: [
        .macOS(.v10_10), .iOS(.v8), .tvOS(.v9)
    ],
    products: [
        .library(
            name: "Spek",
            targets: ["Spek"]
        ),
    ],
    dependencies: [],
    targets: {
        var mutableTargets: [Target] = [
            .testTarget(name: "SpekTests", dependencies: ["Spek"])
        ]

        #if os(macOS) && canImport(ObjectiveC)
            mutableTargets.append(contentsOf: [
                .target(name: "SpekHelper", dependencies: []),
                .target(name: "Spek", dependencies: ["SpekHelper"])
            ])
        #else
            mutableTargets.append(
                .target(name: "Spek", dependencies: [])
            )
        #endif

        return mutableTargets
    }(),
    swiftLanguageVersions: [.v5]
)
