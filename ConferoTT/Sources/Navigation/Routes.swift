import Nivelir
import SwiftUI

struct Routes {
	static func root (initialRoute: ScreenRoute<MainNC, MainNC>) -> ScreenWindowRoute {
		ScreenWindowRoute()
			.setRoot(to: MainScreen()) { route in route.then(initialRoute) }
			.makeKeyAndVisible()
	}

	static let passcodeFull = ScreenWindowRoute()
		.first(.container(of: MainNC.self))
		.then(passcode)
		.fallback { _, route in
			route
				.setRoot(to: MainScreen())
				.makeKeyAndVisible()
		}

	static let passcode = ScreenRootRoute<MainNC>()
		.first(.container(of: PasscodeScreen.Container.self))
		.makeVisible()
		.fallback { _, route in
			route.push(PasscodeScreen())
		}

	static let fdaFull = ScreenWindowRoute()
		.first(.container(of: MainNC.self))
		.then(fda)
		.fallback { _, route in
			route
				.setRoot(to: MainScreen()) { route in route.then(fda) }
				.makeKeyAndVisible()
		}

	static let fda = ScreenRootRoute<MainNC>()
		.first(.container(of: FDAScreen.Container.self))
		.makeVisible()
		.fallback { _, route in
			route.push(FDAScreen())
		}
}
