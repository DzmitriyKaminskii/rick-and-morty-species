//
//  CharactersCoordinator.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import RxCocoa
import RxSwift

class CharactersCoordinator: BaseCoordinator<Void> {

  private let userInterfaceFactory: CharacterUIFactory
  private weak var rootViewController: UINavigationController?

  init(rootViewController: UINavigationController) {
    self.rootViewController = rootViewController

    userInterfaceFactory = CharacterUIFactory()

    super.init()
  }

  override func start() {
    super.start()

    showCharacterListScreen()
  }

  private func showCharacterListScreen() {
    guard let viewController = ApplicationAssembly
      .resolver
      .resolve(CharacterListTableViewController.self, coordinator: self)
    else {
      fatalError("Expected dependency \(CharacterListTableViewController.self)")
    }

    rootViewController?.setViewControllers([viewController], animated: false)
  }

}

extension CharactersCoordinator: CharactersCoordinatorInput {

  func openCharacterDetailsScreen(character: Character) -> Single<Void> {
    let characterDetailsCoordinator = CharacterDetailsCoordinator(rootViewController: rootViewController,
                                                                  interfaceFactory: userInterfaceFactory,
                                                                  character: character)

    return navigate(to: characterDetailsCoordinator)
  }

}
