import NetworkUtil
import Combine
import Multitool

class FDAService: PFDAService {
	static let logRecordConverter = StandardLogRecordStringConverter(
		requestInfo: StandardRequestInfoStringConverter().convert,
		urlRequest: URLRequestStringConverters.Default().convert,
		urlResponse: URLResponseStringConverters.Default().convert,
		httpUrlResponse: HTTPURLResponseStringConverters.Default().convert,
		requestError: StandardNetworkErrorStringConverter().convert
	)

	let nc = StandardNetworkController()
		.logging { record in print(record.convert(logRecordConverter)) }

	func load (limit: Int) -> AnyPublisher<[FDAModel], RequestError> {
		nc.send(EnforcementRequestDelegate(limit: limit))
	}
}
