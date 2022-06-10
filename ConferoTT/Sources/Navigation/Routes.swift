import Nivelir
struct Routes {
	static func main (initialRoute: ScreenRoute<MainNC, MainNC>) -> ScreenWindowRoute {
		ScreenWindowRoute()
			.setRoot(to: MainScreen()) { route in route.then(initialRoute) }
			.makeKeyAndVisible()
	}

	static let passcode = ScreenRoute<MainNC, MainNC>()
		.first(.container(of: PasscodeVC.self))
		.makeVisible()
		.fallback { _, route in
			route.push(PasscodeScreen())
		}
}
