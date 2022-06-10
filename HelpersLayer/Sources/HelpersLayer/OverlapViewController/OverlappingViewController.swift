import UIKit

public protocol OverlappingViewController where Self: UIViewController {
	var showingTimestamp: DispatchTime? { get set }
	var minHidingTimestamp: DispatchTime { get }

	var minOverlappingInterval: Double { get }

	var showingAnimation: Animation { get }
	var hidingAnimation: Animation { get }

	func prepareForHiding (completion: @escaping () -> Void)
}

public extension OverlappingViewController {
	var minHidingTimestamp: DispatchTime { showingTimestamp.map { $0 + minOverlappingInterval } ?? .init(uptimeNanoseconds: 0) }

	var minOverlappingInterval: Double { 0 }

	var showingAnimation: Animation { .init(duration: 0.5) }
	var hidingAnimation: Animation { .init(duration: 0.5) }

	func prepareForHiding (completion: () -> Void) { completion() }
}
