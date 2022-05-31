//
//  CharacterLinkComponents.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/23/22.
//

import Foundation

class CharacterLinkComponents {

  let locationId: Int?

  init(urlString: String) {
    locationId = Int(urlString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
  }

}
