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
      return NSLocalizedString("gender_female", comment: "")
    case .male:
      return NSLocalizedString("gender_male", comment: "")
    case .genderless:
      return NSLocalizedString("gender_genderless", comment: "")
    case .unknown:
      return NSLocalizedString("unknown_gender", comment: "")
    }
  }

}
