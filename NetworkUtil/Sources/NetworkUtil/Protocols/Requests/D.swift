import Foundation
protocol D: Request {
	var method: String { get }
	var baseUrl: URL { get }
	var path: String { get }

	var body: Data { get }
	var headers: [String: String] { get }
}

extension D {
	func defaultUrl () -> URL { baseUrl.appendingPathComponent(path) }

	func defaultUrlRequest () -> URLRequest {
		var urlRequest = URLRequest(url: defaultUrl())

		urlRequest.httpMethod = method

		return urlRequest
	}
}
