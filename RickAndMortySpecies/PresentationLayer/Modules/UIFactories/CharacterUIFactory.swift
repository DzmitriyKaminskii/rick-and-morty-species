//
//  CharacterUIFactory.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import UIKit

struct CharacterUIFactory {

  private let storyboard = UIStoryboard(name: "Main", bundle: nil)

  private let characterListId = "CharacterList"
  private let characterDetailsId = "CharacterDetails"
  private let chooseFilterDateId = "ChooseFilterDateId"

  func createCharacterListUI(coordinatorInput: CharactersCoordinatorInput) -> CharacterListTableViewController {
    guard let viewController = storyboard.instantiateViewController(withIdentifier: characterListId)
            as? CharacterListTableViewController else {
      fatalError("Expected class \(CharacterListTableViewController.self).")
    }

    let viewModel = CharacterListTableViewModel(characterRepository: CharacterRepository())
    viewModel.updateCoordinator(coordinatorInput)
    viewController.updateViewModel(viewModel)

    return viewController
  }

  func createCharacterDetailsUI(coordinatorInput: CharacterDetailsCoordinatorInput,
                                character: Character) ->
  CharacterDetailsViewController {
    guard let viewController = storyboard.instantiateViewController(withIdentifier: characterDetailsId)
            as? CharacterDetailsViewController else {
      fatalError("Expected class \(CharacterDetailsViewController.self).")
    }

    let viewModel = CharacterDetailsViewModel(character: character, locationRepository: LocationRepository())
    viewModel.updateCoordinator(coordinatorInput)
    viewController.updateViewModel(viewModel)

    return viewController
  }

}
