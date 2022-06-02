// swiftlint:disable force_unwrapping
//  CharacterListAssembly.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/31/22.
//

import Swinject

class CharacterListAssembly: Assembly {

  func assemble(container: Container) {
    container.register(
      CharacterListTableViewController.self,
      viewController: StoryboardScene.Main.characterList
    ) { (resolver, vc, coordinator: CharactersCoordinator) in
      let viewModel = resolver.resolve(CharacterListTableViewModel.self)
      viewModel?.updateCoordinator(coordinator)
      vc.updateViewModel(viewModel)
    }

    container.register(CharacterListTableViewModel.self) { resolver in
      let characterRepository = resolver.resolve(CharacterRepositoryProtocol.self)!

      return CharacterListTableViewModel(characterRepository: characterRepository)
    }
  }

}
