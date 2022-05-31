//
//  Character.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

struct Character: Decodable, Equatable {

  let id: Int
  let name: String
  let status: CharacterStatus
  let species: String
  let type: String
  let gender: CharacterGender
  let origin: CharacterLocation
  let location: CharacterLocation
  let image: String
  let episode: [String]
  let url: String
  let created: String

  static func == (lhs: Character, rhs: Character) -> Bool {
    lhs.id == rhs.id &&
    lhs.name == rhs.name &&
    lhs.status == rhs.status &&
    lhs.species == rhs.species &&
    lhs.type == rhs.type &&
    lhs.gender == rhs.gender &&
    lhs.origin == rhs.origin &&
    lhs.location == rhs.location &&
    lhs.image == rhs.image &&
    lhs.episode == rhs.episode &&
    lhs.url == rhs.url &&
    lhs.created == rhs.created
  }

}
