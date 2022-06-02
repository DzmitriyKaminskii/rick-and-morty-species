//
//  CharacterStatus.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import UIKit

enum CharacterStatus: String, Codable {

  case alive = "Alive"
  case dead = "Dead"
  case unknown

}

extension CharacterStatus {

  var value: String {
    switch self {
    case .alive:
      return Strings.statusAlive
    case .dead:
      return Strings.statusDead
    case .unknown:
      return Strings.unknowStatus
    }
  }

}

extension CharacterStatus {

  var color: UIColor {
    switch self {
    case .alive:
      return UIColor.systemGreen
    case .dead:
      return UIColor.systemRed
    case .unknown:
      return UIColor.systemGray
    }
  }

}
