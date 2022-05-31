//
//  CharacterDetailsCoordinator.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import RxCocoa
import RxSwift

class CharacterDetailsCoordinator: BaseCoordinator<Void> {

  private let character: Character
  private let userInterfaceFactory: CharacterUIFactory
  private weak var rootViewController: UINavigationController?

  init(rootViewController: UINavigationController?, interfaceFactory: CharacterUIFactory, character: Character) {
    self.rootViewController = rootViewController
    self.character = character
    userInterfaceFactory = interfaceFactory

    super.init()
  }

  deinit {
    rootViewController?.popViewController(animated: true)
  }

  override func start() {
    super.start()

    showCharacterDetailsScreen()
  }

  private func showCharacterDetailsScreen() {
    let viewController = userInterfaceFactory.createCharacterDetailsUI(coordinatorInput: self, character: character)

    rootViewController?.pushViewController(viewController, animated: true)
  }

}

extension CharacterDetailsCoordinator: CharacterDetailsCoordinatorInput {

  func close() -> AnyObserver<Void> {
    finishedRelay.asObserver()
  }

}
