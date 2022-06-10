import UIKit
import HelpersLayer
import Combine

@IBDesignable
class PasscodeKeyButtonView: UIView, XibInstantiatable {
	let onTouch = PassthroughSubject<String?, Never>()

	@IBOutlet
	private var button: UIButton?

	@IBInspectable
	var digit: String? {
		get { button?.title(for: .normal) }
		set { button?.setTitle(newValue, for: .normal) }
	}

	override init (frame: CGRect) {
		super.init(frame: frame)

		initSubviews()
	}

	required init? (coder: NSCoder) {
		super.init(coder: coder)

		initSubviews()
	}

	func initSubviews () {
		let view = instantiateView(as: UIView.self)
		addFullframe(view)
	}

	func configure (_ digit: String) {
		button?.setTitle(digit, for: .normal)
	}

	@IBAction
	func touched () {
		onTouch.send(digit)
	}
}
