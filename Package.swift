// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TriforkSwiftNetworking",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "TriforkSwiftNetworking",
            targets: ["TriforkSwiftNetworking"]
        ),
        .library(
            name: "TSNMockHelpers",
            targets: ["TSNMockHelpers"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "TriforkSwiftNetworking",
            dependencies: [],
            path: "Sources/TriforkSwiftNetworking"
        ),
        .target(
            name: "TSNMockHelpers",
            dependencies: [],
            path: "Sources/TSNMockHelpers"
        ),
        .testTarget(
            name: "TriforkSwiftNetworkingTests",
            dependencies: ["TriforkSwiftNetworking", "TSNMockHelpers"]
        ),
        .testTarget(
            name: "TSNMockHelpersTests",
            dependencies: ["TSNMockHelpers"]
        )
    ]
)
