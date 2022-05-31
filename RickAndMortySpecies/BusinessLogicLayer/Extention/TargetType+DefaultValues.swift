//
//  TargetType+DefaultValues.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import Moya

extension TargetType {

  var baseURL: URL {
    let urlString = BuildConfiguration.baseURL
    guard let baseURL = URL(string: urlString) else {
      fatalError("Cannot create the baseURL" )
    }
    return baseURL
  }

  var headers: [String: String]? { nil }

  var sampleData: Data { Data() }

}
