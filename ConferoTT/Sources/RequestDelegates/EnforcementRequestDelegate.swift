import NetworkUtil
import NetworkLayer

struct EnforcementRequestDelegate: RequestDelegate {
	let limit: Int

	func request (_ requestInfo: RequestInfo) throws -> EnforcementRequest {
		.init(baseUrl: Configuration.baseUrl, limit: limit)
	}

	func content (_ response: EnforcementRequest.Response, _ requestInfo: RequestInfo) throws -> [FDAModel] {
		response.model.results.map {
			.init(
				eventId: $0.eventId,
				productDecription: $0.productDescription
			)
		}
	}
}
