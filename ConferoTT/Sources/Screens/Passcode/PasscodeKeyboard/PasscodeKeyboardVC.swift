import UIKit
import HelpersLayer
import Combine

class PasscodeKeyboardVC: UIViewController, StoryboardInstantiatable {
	private var subscriptions = Set<AnyCancellable>()

	let onTouch = PassthroughSubject<String?, Never>()

	@IBOutlet
	var buttons: [PasscodeKeyButtonView]?

	override func viewDidLoad () {
		super.viewDidLoad()

		buttons?.forEach { button in
			button.onTouch.sink { [weak self] in self?.onTouch.send($0) }.store(in: &subscriptions)
		}
	}
}
