// swiftlint:disable force_unwrapping
//  CharacterDetailsAssembly.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 6/2/22.
//

import Swinject

class CharacterDetailsAssembly: Assembly {

  func assemble(container: Container) {
    container.register(
      CharacterDetailsViewController.self,
      viewController: StoryboardScene.Main.characterDetails
    ) { (resolver, vc, coordinator: CharacterDetailsCoordinator, parameter: Character) in
      let viewModel = resolver.resolve(CharacterDetailsViewModel.self, argument: parameter)
      viewModel?.updateCoordinator(coordinator)
      vc.updateViewModel(viewModel)
    }

    container.register(CharacterDetailsViewModel.self) { (resolver, character: Character) in
      let locationRepository = resolver.resolve(LocationRepositoryProtocol.self)!

      return CharacterDetailsViewModel(character: character, locationRepository: locationRepository)
    }

    container.register(
      CharacterDetailsViewController.self,
      viewController: StoryboardScene.Main.characterDetails
    ) { (resolver, vc, coordinator: CharacterDetailsCoordinator, parameter: Int) in
      let viewModel = resolver.resolve(CharacterDetailsViewModel.self, argument: parameter)
      viewModel?.updateCoordinator(coordinator)
      vc.updateViewModel(viewModel)
    }

    container.register(CharacterDetailsViewModel.self) { (resolver, character: Int) in
      let locationRepository = resolver.resolve(LocationRepositoryProtocol.self)!
      let characterRepository = resolver.resolve(CharacterRepositoryProtocol.self)!

      return CharacterDetailsViewModel(characterId: character,
                                       locationRepository: locationRepository,
                                       characterRepository: characterRepository)
    }

  }

}
