//
//  CharacterListResponse.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

struct CharacterListResponse: Decodable, Equatable {

  let info: InfoBlock
  let results: [Character]

  static func == (lhs: CharacterListResponse, rhs: CharacterListResponse) -> Bool {
    lhs.info == rhs.info &&
    lhs.results == rhs.results
  }

}
