//
//  CharacterRepository.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import Moya
import RxSwift

class CharacterRepository: CharacterRepositoryProtocol {

  private let provider: RickAndMortyMoyaProvider<CharacterAPI>

  convenience init() {
    let provider = RickAndMortyMoyaProvider<CharacterAPI>()
    self.init(provider: provider)
  }

  init(provider: RickAndMortyMoyaProvider<CharacterAPI>) {
    self.provider = provider
  }

  func loadCharacter(id: Int) -> Single<Character> {
    let requestEndpoint = CharacterAPI.character(characterId: id)
    return provider.request(requestEndpoint, responseType: Character.self)
  }

  func loadCharacterList(pagination: PaginationParams) -> Single<CharacterListResponse> {
    let requestEndpoint = CharacterAPI.characterList(pagination: pagination)
    return provider.request(requestEndpoint, responseType: CharacterListResponse.self)
  }

}
