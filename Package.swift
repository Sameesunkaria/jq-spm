// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "jq-spm",
    products: [
        .executable(
            name: "jq",
            targets: ["jq"]),
        .library(
            name: "Cjq",
            targets: ["Cjq"]),
    ],
    dependencies: [
    ],
    targets: [
        .executableTarget(
            name: "jq",
            dependencies: [
                "Cjq"
            ],
            cSettings: [
                .define("HAVE_ISATTY"),
            ]),
        .target(
            name: "Cjq",
            resources: [
                .copy("src/builtin.inc"),
            ],
            cSettings: [
                .define("IEEE_8087", to: "1"),
            ]),
        .testTarget(
            name: "CjqTests",
            dependencies: ["Cjq"])
    ]
)
