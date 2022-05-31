//
//  CharacterLocation.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

struct CharacterLocation: Decodable, Equatable {

  let name: String
  let url: String

  static func == (lhs: CharacterLocation, rhs: CharacterLocation) -> Bool {
    lhs.name == rhs.name &&
    lhs.url == rhs.url
  }

}
