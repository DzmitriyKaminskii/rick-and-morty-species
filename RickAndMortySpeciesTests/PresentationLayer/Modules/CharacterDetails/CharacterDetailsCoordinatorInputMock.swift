//
//  CharacterDetailsCoordinatorInputMock.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/13/22.
//

@testable import RickAndMortySpecies

import RxSwift
import RxCocoa

class CharacterDetailsCoordinatorInputMock: CharacterDetailsCoordinatorInput {

  func close() -> AnyObserver<Void> {
    PublishRelay<Void>().asObserver()
  }

}
