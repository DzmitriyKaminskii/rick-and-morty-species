import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  private var deepLinkHandler: DeeplinkHandlerProtocol?
  private var rootCoordinator: RootCoordinator?

  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {

    if let windowScene = scene as? UIWindowScene {

      let window = UIWindow(windowScene: windowScene)

      let rootCoordinator = RootCoordinator(window: window)
      self.rootCoordinator = rootCoordinator
      self.deepLinkHandler = DeepLinkHandler(coordinator: rootCoordinator)
      rootCoordinator.start()

    }

    if let urlContext = connectionOptions.urlContexts.first {
      deepLinkHandler?.handlerURLContext(urlContext)
    }
  }

  func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    deepLinkHandler?.handlerURLContext(URLContexts)
  }

}
