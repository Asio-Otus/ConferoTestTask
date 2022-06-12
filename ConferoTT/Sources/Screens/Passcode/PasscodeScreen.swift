import Nivelir

struct PasscodeScreen: Screen {
	let mainCoordinator: MainCoordinator
	let passcodeService: PasscodeService

	func build (navigator: ScreenNavigator) -> PasscodeVC {
		.instantiate()
		.set(
			vm: PasscodeVM(
				mainCoordinator: mainCoordinator,
				passcodeService: passcodeService
			)
		)
	}
}
