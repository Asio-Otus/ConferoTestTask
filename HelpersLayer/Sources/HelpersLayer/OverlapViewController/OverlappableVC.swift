import UIKit

public protocol OverlappableVC: UIViewController {
	var overlappingVC: OverlappingViewController { get }
}

public extension OverlappableVC {
	func onOverlapShowingStart () { }
	func onOverlapShowingEnd () { }
	func onOverlapHidingStart () { }
	func onOverlapHidingEnd () { }
}

public extension OverlappableVC {
	func showOverlap (completion: @escaping () -> Void = { }) {
		onOverlapShowingStart()

		DispatchQueue.main.async {
			guard !self.children.contains(where: { $0 === self.overlappingVC }) else {
				completion()
				self.onOverlapShowingEnd()

				self.overlappingVC.showingTimestamp = nil
				return
			}

			self.overlappingVC.showingTimestamp = .now()

			self.addChild(self.overlappingVC)
			self.view.addFullframe(self.overlappingVC.view)

			UIView.transition(
				with: self.view,
				duration: self.overlappingVC.showingAnimation.duration,
				options: self.overlappingVC.showingAnimation.options,
				animations: self.overlappingVC.showingAnimation.animation,
				completion: { _ in
					self.overlappingVC.didMove(toParent: self)
					completion()
					self.onOverlapShowingEnd()
				}
			)
		}
	}

	func hideOverlap (completion: @escaping () -> Void = { }) {
		onOverlapHidingStart()

		DispatchQueue.main.asyncAfter(deadline: overlappingVC.minHidingTimestamp) {
			guard self.children.contains(where: { $0 === self.overlappingVC }) else {
				completion()
				self.onOverlapHidingEnd()

				self.overlappingVC.showingTimestamp = nil
				return
			}

			self.overlappingVC.prepareForHiding {
				UIView.transition(
					with: self.view,
					duration: self.overlappingVC.hidingAnimation.duration,
					options: self.overlappingVC.hidingAnimation.options,
					animations: {
						self.overlappingVC.removeFromHierarchy {
							self.overlappingVC.hidingAnimation.animation()
						}
					},
					completion: { _ in
						completion()
						self.onOverlapHidingEnd()

						self.overlappingVC.showingTimestamp = nil
					}
				)
			}
		}
	}
}

public extension OverlappableVC {
	func overlappedAction (action: @escaping (@escaping ((@escaping () -> Void) -> Void)) -> Void) {
		showOverlap {
			action { completion in
				self.hideOverlap(completion: completion)
			}
		}
	}

	func overlappedActionImmediately (action: @escaping (() -> Void) -> Void, completion: @escaping () -> Void = { }) {
		showOverlap()
		action {
			self.hideOverlap(completion: completion)
		}
	}
}
