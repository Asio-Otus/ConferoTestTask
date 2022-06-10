import Foundation

public struct StandardNetworkErrorStringConverter: RequestErrorStringConverter {
	public init () { }

	public func convert (_ error: RequestError) -> String {
        "\(error.name.uppercased()) ERROR – \(error.innerError)"
	}
}
