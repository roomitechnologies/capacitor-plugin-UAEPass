// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "IonicLoginUaePass",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "IonicLoginUaePass",
            targets: ["LoginWithUAEPassPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "main")
    ],
    targets: [
        .target(
            name: "LoginWithUAEPassPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/LoginWithUAEPassPlugin"),
        .testTarget(
            name: "LoginWithUAEPassPluginTests",
            dependencies: ["LoginWithUAEPassPlugin"],
            path: "ios/Tests/LoginWithUAEPassPluginTests")
    ]
)