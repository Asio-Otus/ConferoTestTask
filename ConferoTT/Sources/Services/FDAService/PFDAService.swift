import Combine
import NetworkUtil

protocol PFDAService {
	func load (limit: Int) -> AnyPublisher<[FDAModel], RequestError>
}
