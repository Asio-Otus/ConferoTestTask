import UIKit

protocol ViewModelContainable: UIViewController {
	associatedtype ViewModel

	var vm: ViewModel! { get set }
}

extension ViewModelContainable {
	@discardableResult
	func set (vm: ViewModel) -> Self {
		self.vm = vm
		return self
	}
}
