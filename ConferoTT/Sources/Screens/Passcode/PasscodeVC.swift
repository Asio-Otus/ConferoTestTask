import UIKit
import HelpersLayer
import Combine

class PasscodeVC: UIViewController,
				  ViewModelContainable,
				  StoryboardInstantiatable {
	private var subscriptions = Set<AnyCancellable>()

	private let passcodeKeyboardVC = PasscodeKeyboardVC.instantiate()

	@IBOutlet
	private var passcodeTextField: UITextField?

	@IBOutlet
	private var keyboardView: UIView?

	var vm: PPasscodeVM!

	override func viewDidLoad () {
		super.viewDidLoad()

		setupSubscriptions()
		setupViews()
	}

	private func setupSubscriptions () {
		passcodeKeyboardVC.onTouch.sink { [weak self] in self?.vm.nextDigitTrigger.send($0) }
		.store(in: &subscriptions)

		vm.passcode.sink { [weak self] in
			self?.passcodeTextField?.text = $0 }
		.store(in: &subscriptions)
	}

	private func setupViews () {
		keyboardView.map { insertFullframeChild(passcodeKeyboardVC, to: $0) }
	}
}
