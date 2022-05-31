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
      return NSLocalizedString("status_alive", comment: "")
    case .dead:
      return NSLocalizedString("status_dead", comment: "")
    case .unknown:
      return NSLocalizedString("unknow_status", comment: "")
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
