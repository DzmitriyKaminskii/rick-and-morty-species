//
//  Encodable+Dictionary.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import Foundation

extension Encodable {

  func asDictionary() -> [String: Any] {
    guard let encodedData = try? JSONEncoder().encode(self),
          let jsonObject = try? JSONSerialization.jsonObject(with: encodedData, options: []),
          let dictionary = jsonObject as? [String: Any] else {
      fatalError("Error while mapping the object: \(self) to dictionary!")
    }
    return dictionary
  }

}
