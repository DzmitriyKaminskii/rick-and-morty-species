//
//  RootCoordinator.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import RxCocoa
import RxSwift

final class RootCoordinator: BaseCoordinator<Void> {

  private let window: UIWindow

  private lazy var rootViewController = UINavigationController(rootViewController: UIViewController())

  init(window: UIWindow) {
    self.window = window
  }

  override func start() {
    super.start()

    window.rootViewController = rootViewController
    window.makeKeyAndVisible()

    startCharacterCoordinator()
      .subscribe()
      .disposed(by: disposeBag)
  }

  override func handleLink(_ linkData: LinkData) {
    if let coordinator = childCoordinators.first(where: { $0.canHandleLink(linkType: linkData.type) }) {
      coordinator.handleLink(linkData)
    }
  }

  private func startCharacterCoordinator() -> Single<Void> {
    let characterCoordinator = CharactersCoordinator(rootViewController: rootViewController)

    return navigate(to: characterCoordinator)
  }

}
