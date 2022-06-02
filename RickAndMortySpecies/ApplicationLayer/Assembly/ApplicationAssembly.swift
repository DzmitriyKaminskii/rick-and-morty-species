//
//  ApplicationAssembly.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/31/22.
//

import Swinject

enum ApplicationAssembly {

  static var resolver: Resolver {
    assembler.resolver
  }

  private static var assembler: Assembler = Assembler([
    RepositoriesAssembly(),
    CharacterListAssembly(),
    CharacterDetailsAssembly()
  ])

}
