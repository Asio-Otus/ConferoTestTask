import Nivelir

class PasscodeScreen: Screen {
	func build (navigator: ScreenNavigator) -> PasscodeVC {
		.instantiate()
		.set(vm: PasscodeVM(passcodeService: PasscodeService()))
	}	
}
