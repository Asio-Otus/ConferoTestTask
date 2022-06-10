import Nivelir

class PasscodeScreen: Screen {
	func build (navigator: ScreenNavigator) -> PasscodeVC {
		.instantiate()
		.set(
			vm: PasscodeVM(
				navigator: navigator,
				passcodeService: PasscodeService()
			)
		)
	}	
}
