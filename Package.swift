// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "MyMatchers",
    platforms: [
      .iOS(.v10)
    ],
    products: [        
        .library(name: "MyMatchers", targets: ["MyMatchers"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble", from: "9.0.0"),
        .package(url: "https://github.com/Quick/Quick", from: "3.0.0"),
    ],
    targets: [     
        .target(name: "MyMatchers", dependencies: ["Quick", "Nimble"], path: "MyMatchers/Classes/"),
    ],
    swiftLanguageVersions: [.v5]
)
