//
//  BuildConfiguration.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import Foundation

enum BuildConfiguration {

  private enum Keys {

    static let baseURL = "base_url"

  }

  static var baseURL: String {
    guard let url = Bundle.main.object(forInfoDictionaryKey: Keys.baseURL) as? String else {
      fatalError("Cannot fetch baseURL")
    }
    return url
  }

}
