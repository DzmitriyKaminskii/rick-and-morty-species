//
//  CharacterDetailsCoordinatorInput.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/22/22.
//

import RxSwift

protocol CharacterDetailsCoordinatorInput: CoordinatorInput {

  func close() -> AnyObserver<Void>

}
