// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "NetworkUtil",
	platforms: [
		.iOS(.v11),
		.macOS(.v10_15)
	],
	products: [
		.library(
			name: "NetworkUtil",
			targets: ["NetworkUtil"]
		),
	],
	targets: [.target(name: "NetworkUtil")]
)
