//
//  CharactersAPI.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import Moya

enum CharacterAPI {

  case characterList(pagination: PaginationParams)
  case character(characterId: Int)

}

extension CharacterAPI: TargetType {

  var path: String {
    switch self {
    case .characterList:
      return "/character"
    case .character(let id):
      return "/character/\(id)"
    }
  }

  var method: Moya.Method {
    .get
  }

  var task: Task {
    switch self {
    case .characterList(let pagination):
      return .requestParameters(parameters: pagination.asDictionary(),
                                encoding: URLEncoding(arrayEncoding: .noBrackets))
    case .character:
      return .requestPlain
    }
  }

}
