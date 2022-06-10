import Combine
import Nivelir

class PasscodeVM: PPasscodeVM {
	private var subscriptions = Set<AnyCancellable>()

	private let navigator: ScreenNavigator
	private let passcodeService: PPasscodeService

	let passcode = CurrentValueSubject<String, Never>("")
	let nextDigitTrigger = PassthroughSubject<String?, Never>()

	init (navigator: ScreenNavigator, passcodeService: PPasscodeService) {
		self.navigator = navigator
		self.passcodeService = passcodeService

		setupSubscriptions()
	}

	private func setupSubscriptions () {
		nextDigitTrigger
			.compactMap { $0 }
			.combineLatest(passcode) { $1 + $0 }
			.sink { [weak self] in
				guard let self = self else { return }

				self.passcode.send($0)

				if $0.count >= Configuration.passcodeLength {
					if self.passcodeService.isValid(passcode: $0) == true {
						self.navigator.navigate(to: Routes.fdaFull)
					}

					self.passcode.send("")
				}
			}
			.store(in: &subscriptions)
		
	}
}
