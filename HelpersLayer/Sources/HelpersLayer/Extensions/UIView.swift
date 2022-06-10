import UIKit

public extension UIView {
	@discardableResult
	func pinBounds (to view: UIView) -> Self {
		translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: view.topAnchor),
			bottomAnchor.constraint(equalTo: view.bottomAnchor),
			leadingAnchor.constraint(equalTo: view.leadingAnchor),
			trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

		return self
	}

	@discardableResult
	func addFullframe (_ view: UIView) -> Self {
		addSubview(view)

		view.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: topAnchor),
			view.bottomAnchor.constraint(equalTo: bottomAnchor),
			view.leadingAnchor.constraint(equalTo: leadingAnchor),
			view.trailingAnchor.constraint(equalTo: trailingAnchor)
		])

		return self
	}
}

public extension UIView {
	@IBInspectable
	var cornerRadius: CGFloat {
		get { layer.cornerRadius }
		set { layer.cornerRadius = newValue  }
	}
}
