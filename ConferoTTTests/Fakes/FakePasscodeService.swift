@testable import ConferoTT

class FakePasscodeService: PPasscodeService {
	var correctPasscode = "1234"

	init (correctPasscode: String) {
		self.correctPasscode = correctPasscode
	}

	func isValid (passcode: String) -> Bool {
		passcode == correctPasscode
	}
}
