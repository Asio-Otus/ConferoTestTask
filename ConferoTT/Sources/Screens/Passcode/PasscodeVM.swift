import Combine

class PasscodeVM: PPasscodeVM {
	private var subscriptions = Set<AnyCancellable>()

	let passcode = CurrentValueSubject<String, Never>("")
	let nextDigitTrigger = PassthroughSubject<String?, Never>()

	let passcodeService: PPasscodeService

	init (passcodeService: PPasscodeService) {
		self.passcodeService = passcodeService

		setupSubscriptions()
	}

	private func setupSubscriptions () {
		nextDigitTrigger
			.compactMap { $0 }
			.combineLatest(passcode) { $1 + $0 }
			.sink { [weak self] in
				self?.passcode.send($0)

				if $0.count >= Configuration.passcodeLength {
					if self?.passcodeService.isValid(passcode: $0) == true {

					}

					self?.passcode.send("")
				}
			}
			.store(in: &subscriptions)
		
	}
}
