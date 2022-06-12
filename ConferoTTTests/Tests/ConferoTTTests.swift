import XCTest
import Nivelir
import Combine
@testable import ConferoTT

class ConferoTTTests: XCTestCase {
	private var subscriptions: Set<AnyCancellable>!

	override func setUp() {
		super.setUp()

		subscriptions = []
	}

	func testPasscodeVMCorrectPasscode () {
		var passcodes = [String]()
		var isNavigationPerformed = false

		let expectation = expectation(description: "")
		let mockCoordinator = MockMainCoordinator()
			.setMockOnCorrectPasscode { isNavigationPerformed = true }
		let fakePasscodeService = FakePasscodeService(correctPasscode: "4321")

		let vm = PasscodeVM(mainCoordinator: mockCoordinator, passcodeService: fakePasscodeService)

		vm.passcode
			.sink { passcodes.append($0) }
			.store(in: &subscriptions)

		vm.passcode
			.dropFirst(5)
			.sink { _ in expectation.fulfill() }
			.store(in: &subscriptions)

		vm.nextDigitTrigger.send("4")
		vm.nextDigitTrigger.send("3")
		vm.nextDigitTrigger.send("2")
		vm.nextDigitTrigger.send("1")

		waitForExpectations(timeout: 1)

		XCTAssertEqual(passcodes, ["", "4", "43", "432", "4321", ""])
		XCTAssertEqual(isNavigationPerformed, true)
	}

	func testPasscodeVMIncorrectPasscode () {
		var passcodes = [String]()
		var isNavigationPerformed = false

		let expectation = expectation(description: "")
		let mockCoordinator = MockMainCoordinator()
			.setMockOnCorrectPasscode { isNavigationPerformed = true }
		let fakePasscodeService = FakePasscodeService(correctPasscode: "1234")

		let vm = PasscodeVM(mainCoordinator: mockCoordinator, passcodeService: fakePasscodeService)

		vm.passcode
			.sink { passcodes.append($0) }
			.store(in: &subscriptions)

		vm.passcode
			.dropFirst(5)
			.sink { _ in expectation.fulfill() }
			.store(in: &subscriptions)

		vm.nextDigitTrigger.send("4")
		vm.nextDigitTrigger.send("3")
		vm.nextDigitTrigger.send("2")
		vm.nextDigitTrigger.send("1")

		waitForExpectations(timeout: 1)

		XCTAssertEqual(passcodes, ["", "4", "43", "432", "4321", ""])
		XCTAssertEqual(isNavigationPerformed, false)
	}
}
