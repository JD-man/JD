// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "JDA",
  
  platforms: [.iOS(.v15)],
  
  products: [
    .library(
      name: "JDA",
      targets: ["JDA"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "JDA",
      dependencies: []),
    .testTarget(
      name: "JDATests",
      dependencies: ["JDA"]),
  ]
)
