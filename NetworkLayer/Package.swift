// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "NetworkLayer",
	platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "NetworkLayer",
            targets: ["NetworkLayer"]
		)
    ],
	dependencies: [
		.package(
			name: "NetworkUtil",
			path: "../NetworkUtil"
		)
	],
    targets: [
		.target(
			name: "NetworkLayer",
			dependencies: ["NetworkUtil"]
		)
	]
)
