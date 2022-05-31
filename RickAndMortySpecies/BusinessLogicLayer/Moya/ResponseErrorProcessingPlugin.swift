//
//  ResponseErrorProcessingPlugin.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import Moya

class ResponseErrorProcessingPlugin: PluginType {

  func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {

    switch result {
    case .success(let response):
      if !(200 ... 299 ~= response.statusCode) {
        guard let jsonResponse = try? JSONSerialization.jsonObject(with: response.data) else {
          return .failure(MoyaError.jsonMapping(response))
        }

        if let responseDictionary = jsonResponse as? [String: Any],
           let message = responseDictionary["error"] as? String {
          return .failure(MoyaError.underlying(RickAndMortyAPIError.response(message: message), response))
        }
      }

      return result
    case .failure:
      return result
    }
  }

}
