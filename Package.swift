// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Spek",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Spek",
            targets: ["Spek"]
        ),
    ],
    dependencies: [],
    targets: {
        var mutableTargets: [Target] = []
        /*
        #if os(macOS)
            mutableTargets.append(contentsOf: [
                .target(name: "SpekHelper", dependencies: []),
                .target(name: "Spek", dependencies: ["SpekHelper"], exclude: [
                    "Sources/Spek/SpekTestCase"
                ])
            ])
        #else
            mutableTargets.append(
                .target(name: "Spek", dependencies: [], exclude: [
                    "Sources/Spek/SpekTestCase"
                ])
            )
        #endif
        */

        mutableTargets.append(contentsOf: [
            .target(name: "Spek", dependencies: [], exclude: [
                "Sources/Spek/SpekTestCase"
            ]),
            .testTarget(name: "SpekTests", dependencies: ["Spek"])
        ])

        return mutableTargets
    }(),
    swiftLanguageVersions: [.v5]
)
