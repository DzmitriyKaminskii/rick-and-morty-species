//
//  CharacterDetailsCoordinator.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import UIKit

import RxCocoa
import RxSwift

class CharacterDetailsCoordinator: BaseCoordinator<Void> {

  private let character: Character?
  private let characterId: Int?

  private weak var rootViewController: UINavigationController?

  init(rootViewController: UINavigationController?, character: Character? = nil, characterId: Int? = nil) {
    self.character = character
    self.characterId = characterId
    self.rootViewController = rootViewController

    super.init()
  }

  deinit {
    rootViewController?.popViewController(animated: true)
  }

  override func start() {
    super.start()

    if let object = character { showCharacterDetailsScreen(byCharacter: object) }
    if let id = characterId { showCharacterDetailsScreen(byCharacterId: id) }
  }

  private func showCharacterDetailsScreen(byCharacter character: Character) {
    guard let viewController = ApplicationAssembly
      .resolver
      .resolve(CharacterDetailsViewController.self, coordinator: self, coordinatorParameter: character)
    else {
      fatalError("Expected dependency \(CharacterDetailsViewController.self)")
    }

    rootViewController?.pushViewController(viewController, animated: true)
  }

  private func showCharacterDetailsScreen(byCharacterId characterId: Int) {
    guard let viewController = ApplicationAssembly
      .resolver
      .resolve(CharacterDetailsViewController.self, coordinator: self, coordinatorParameter: characterId)
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
