import NetworkUtil
import Foundation

public protocol FDARequest: Request {
	static var path: String { get }

	var baseUrl: URL { get }
	var queryItems: [URLQueryItem] { get }
}

public extension FDARequest {
	func url () -> URL? {
		var urlComponents = URLComponents(string: baseUrl.appendingPathComponent(Self.path).absoluteString)
		urlComponents?.queryItems = queryItems
		return urlComponents?.url
	}

	func urlRequest () throws -> URLRequest {
		guard let url = url() else { throw "URL creation failed" }
		return .init(url: url)
	}
}
