// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PersistenceManager",
    platforms: [
        .iOS(.v17), // Adjust the platform as per your requirements
       ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PersistenceManager",
            targets: ["PersistenceManager"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PersistenceManager"),
        .testTarget(
            name: "PersistenceManagerTests",
            dependencies: ["PersistenceManager"]
        ),
    ]
)
