//
//  CharacterRepositoryProvider.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import RxSwift

protocol CharacterRepositoryProtocol {

  func loadCharacterList(pagination: PaginationParams) -> Single<CharacterListResponse>

}
