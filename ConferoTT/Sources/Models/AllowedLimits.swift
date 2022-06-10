enum AllowedLimits: CaseIterable, Hashable {
	case l1
	case l7
	case l20

	var description: String {
		switch self {
		case .l1: return "1"
		case .l7: return "7"
		case .l20: return "20"
		}
	}

	var value: Int {
		switch self {
		case .l1: return 1
		case .l7: return 7
		case .l20: return 20
		}
	}
}
