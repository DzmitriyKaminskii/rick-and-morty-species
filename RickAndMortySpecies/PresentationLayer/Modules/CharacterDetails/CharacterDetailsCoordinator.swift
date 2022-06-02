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
  private weak var rootViewController: UINavigationController?

  init(rootViewController: UINavigationController?, character: Character) {
    self.rootViewController = rootViewController
    self.character = character

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
    guard let viewController = ApplicationAssembly
      .resolver
      .resolve(CharacterDetailsViewController.self, coordinator: self, coordinatorParameter: character)
    else {
      fatalError("Expected dependency \(CharacterDetailsViewController.self)")
    }

    rootViewController?.pushViewController(viewController, animated: true)
  }

}

extension CharacterDetailsCoordinator: CharacterDetailsCoordinatorInput {

  func close() -> AnyObserver<Void> {
    finishedRelay.asObserver()
  }

}
