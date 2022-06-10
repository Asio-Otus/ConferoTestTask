import Foundation
import NetworkUtil

public struct EnforcementRequest: FDARequest {
	public static var path: String = "food/enforcement.json"

	public let baseUrl: URL
	public let limit: Int
	public var queryItems: [URLQueryItem] {
		[.init(name: "limit", value: limit.description)]
	}

	public init (baseUrl: URL, limit: Int) {
		self.baseUrl = baseUrl
		self.limit = limit
	}
}

extension EnforcementRequest {
	public struct Response: FDAResponse {
		public let data: Data
		public let urlResponse: URLResponse
		public let model: Model

		public init (_ data: Data, _ urlResponse: URLResponse) throws {
			self.data = data
			self.urlResponse = urlResponse
			self.model = try .init(data)
		}
	}
}

extension EnforcementRequest.Response {
	public struct Model: ResponseModel {
		public let results: [ResultModel]
	}
}

extension EnforcementRequest.Response.Model {
	public struct ResultModel: Decodable {
		enum CodingKeys: String, CodingKey {
			case eventId = "event_id"
			case productDescription = "product_description"
		}

		public let eventId: String
		public let productDescription: String
	}
}
