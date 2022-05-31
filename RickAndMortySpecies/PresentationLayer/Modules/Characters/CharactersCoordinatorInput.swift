//
//  CharactersCoordinatorInput.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/20/22.
//

import RxSwift

protocol CharactersCoordinatorInput: CoordinatorInput {

  func openCharacterDetailsScreen(character: Character) -> Single<Void>

}
