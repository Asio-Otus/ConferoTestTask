import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?
	var mainCoordinator: MainCoordinator!

	func scene (_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		let window = UIWindow(windowScene: windowScene)
		self.mainCoordinator = MainCoordinator(window: window)
		self.mainCoordinator.start()

		self.window = window
	}
}
