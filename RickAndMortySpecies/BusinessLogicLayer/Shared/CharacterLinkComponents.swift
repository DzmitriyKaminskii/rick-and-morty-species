//
//  CharacterLinkComponents.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/23/22.
//

import Foundation

enum CharacterLinkComponents {

  static func getLocationId(by urlString: String?) -> Int? {
    guard let urlString = urlString else { return nil }

    return Int(urlString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
  }

}
