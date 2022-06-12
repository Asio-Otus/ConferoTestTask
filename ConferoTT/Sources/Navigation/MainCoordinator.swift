import UIKit
import Nivelir

class MainCoordinator: PMainCoordinator {
	private let window: UIWindow
	private let navigator: ScreenNavigator

	init (window: UIWindow) {
		self.window = window
		self.navigator = .init(window: window)
	}
}

extension MainCoordinator {
	func start () {
		navigator.navigate(
			to: Routes.root(
				initialRoute: Routes.passcode(
					mainCoordinator: self,
					passcodeService: PasscodeService()
				)
			)
		)
	}

	func onCorrectPasscode () {
		navigator.navigate(to: Routes.fdaFromRoot())
	}
}
