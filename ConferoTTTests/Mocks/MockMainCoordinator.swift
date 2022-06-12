@testable import ConferoTT

class MockMainCoordinator {
	var mockStart: () -> Void = { }
	var mockOnCorrectPasscode: () -> Void = { }

	@discardableResult
	func setMockStart (_ mockStart: @escaping () -> Void) -> Self {
		self.mockStart = mockStart
		return self
	}

	@discardableResult
	func setMockOnCorrectPasscode (_ mockOnCorrectPasscode: @escaping () -> Void) -> Self {
		self.mockOnCorrectPasscode = mockOnCorrectPasscode
		return self
	}
}

extension MockMainCoordinator: PMainCoordinator {
	func start () {
		mockStart()
	}

	func onCorrectPasscode () {
		mockOnCorrectPasscode()
	}
}
