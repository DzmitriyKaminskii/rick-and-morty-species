import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  private var rootCoordinator: RootCoordinator?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    if let windowScene = scene as? UIWindowScene {

      let window = UIWindow(windowScene: windowScene)

      let rootCoordinator = RootCoordinator(window: window)
      self.rootCoordinator = rootCoordinator

      rootCoordinator.start()
    }
  }

}
