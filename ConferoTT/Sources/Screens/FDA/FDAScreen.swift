import Nivelir
import SwiftUI

class FDAScreen: Screen {
	func build (navigator: ScreenNavigator) -> UIHostingController<FDAView> {
		.init(rootView: .init(vm: .init()))
	}
}
