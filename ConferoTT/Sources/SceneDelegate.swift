import UIKit
import Nivelir

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	var navigator: ScreenNavigator!

	func scene (_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)
		let navigator = ScreenNavigator(window: window)

		navigator.navigate(to: Routes.root(initialRoute: Routes.passcode))

		self.window = window
		self.navigator = navigator
	}
}
