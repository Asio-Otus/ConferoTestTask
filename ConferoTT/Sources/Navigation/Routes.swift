import Nivelir
import SwiftUI

struct Routes {
	static func root (initialRoute: ScreenRoute<MainNC, MainNC>) -> ScreenWindowRoute {
		ScreenWindowRoute()
			.setRoot(to: MainScreen()) { route in route.then(initialRoute) }
			.makeKeyAndVisible()
	}

	static func passcodeFromRoot (mainCoordinator: MainCoordinator, passcodeService: PasscodeService) -> ScreenWindowRoute {
		.init()
		.first(.container(of: MainNC.self))
		.then(
			passcode(
				mainCoordinator: mainCoordinator,
				passcodeService: passcodeService
			)
		)
		.fallback { _, route in
			route
				.setRoot(to: MainScreen())
				.makeKeyAndVisible()
		}
	}

	static func passcode (mainCoordinator: MainCoordinator, passcodeService: PasscodeService) -> ScreenRootRoute<MainNC> {
		.init()
		.first(.container(of: PasscodeScreen.Container.self))
		.makeVisible()
		.fallback { _, route in
			route.push(
				PasscodeScreen(
					mainCoordinator: mainCoordinator,
					passcodeService: passcodeService
				)
			)
		}
	}

	static func fdaFromRoot () -> ScreenWindowRoute {
		.init()
		.first(.container(of: MainNC.self))
		.then(fda())
		.fallback { _, route in
			route
				.setRoot(to: MainScreen()) { route in route.then(fda()) }
				.makeKeyAndVisible()
		}
	}

	static func fda () -> ScreenRootRoute<MainNC> {
		.init()
		.first(.container(of: FDAScreen.Container.self))
		.makeVisible()
		.fallback { _, route in
			route.push(FDAScreen())
		}
	}
}
