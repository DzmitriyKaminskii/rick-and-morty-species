//
//  Location.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

struct Location: Decodable, Equatable {

  let id: Int
  let name: String
  let type: String
  let dimension: String
  let residents: [String]
  let url: String
  let created: String

  static func == (lhs: Location, rhs: Location) -> Bool {
    lhs.id == rhs.id &&
    lhs.name == rhs.name &&
    lhs.type == rhs.type &&
    lhs.dimension == rhs.dimension &&
    lhs.residents == rhs.residents &&
    lhs.url == rhs.url &&
    lhs.created == rhs.created
  }

}
