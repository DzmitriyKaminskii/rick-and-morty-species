//
//  CharacterRepositoryProvider.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import RxSwift

protocol CharacterRepositoryProtocol {

  func loadCharacter(id: Int) -> Single<Character>
  func loadCharacterList(pagination: PaginationParams) -> Single<CharacterListResponse>

}
