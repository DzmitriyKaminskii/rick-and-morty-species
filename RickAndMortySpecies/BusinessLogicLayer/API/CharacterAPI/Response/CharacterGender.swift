//
//  CharacterGender.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import Foundation

enum CharacterGender: String, Codable {

  case female = "Female"
  case male = "Male"
  case genderless = "Genderless"
  case unknown

}

extension CharacterGender {

  var value: String {
    switch self {
    case .female:
      return Strings.genderFemale
    case .male:
      return Strings.genderMale
    case .genderless:
      return Strings.genderGenderless
    case .unknown:
      return Strings.unknownGender
    }
  }

}
