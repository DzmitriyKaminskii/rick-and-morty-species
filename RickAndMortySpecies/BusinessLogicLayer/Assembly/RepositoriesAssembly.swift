//
//  RepositoriesAssembly.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/31/22.
//

import Swinject

class RepositoriesAssembly: Assembly {

  func assemble(container: Container) {
      container.register(CharacterRepositoryProtocol.self) { _ in
           CharacterRepository()
      }
  }

}
