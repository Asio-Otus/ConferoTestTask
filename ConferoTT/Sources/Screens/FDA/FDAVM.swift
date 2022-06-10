import Foundation
import HelpersLayer
import Combine

class FDAVM: PFDAVM, ObservableObject {
	private var subscriptions = Set<AnyCancellable>()
	private let fdaService = FDAService()

	@Published var fdaModels: ProcessingState<Void, AnyCancellable, [FDAModel]> = .init()
	@Published var currentLimit: AllowedLimits = .l1

	init () {
		setupSubscriptions()
	}

	private func setupSubscriptions () {
		$currentLimit
			.sink { [weak self] limit in self?.load(limit.value) }
			.store(in: &subscriptions)
	}

	func load (_ limit: Int) {
		if case let .processing(subscription) = fdaModels {
			subscription.cancel()
		}

		let subscription = fdaService
			.load(limit: limit)
			.receive(on: DispatchQueue.main)
			.sink(
				receiveCompletion: { [weak self] result in
					if case let .failure(error) = result {
						self?.fdaModels = .failed(error)
					}
				},
				receiveValue: { [weak self] fdaModels in
					self?.fdaModels = .completed(fdaModels)
				}
			)

		fdaModels = .processing(subscription)
	}
}
