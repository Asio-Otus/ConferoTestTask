import Combine

protocol PPasscodeVM {
	var passcode: CurrentValueSubject<String, Never> { get }
	var nextDigitTrigger: PassthroughSubject<String?, Never> { get }
}
