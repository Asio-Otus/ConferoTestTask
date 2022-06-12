import Combine

class PasscodeVM: PPasscodeVM {
	private var subscriptions = Set<AnyCancellable>()

	private let mainCoordinator: PMainCoordinator
	private let passcodeService: PPasscodeService

	let passcode = CurrentValueSubject<String, Never>("")
	let nextDigitTrigger = PassthroughSubject<String?, Never>()

	init (mainCoordinator: PMainCoordinator, passcodeService: PPasscodeService) {
		self.mainCoordinator = mainCoordinator
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
						self.mainCoordinator.onCorrectPasscode()
					}

					self.passcode.send("")
				}
			}
			.store(in: &subscriptions)
	}
}
