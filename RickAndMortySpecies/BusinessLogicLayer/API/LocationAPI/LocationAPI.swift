//
//  LocationsAPI.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/18/22.
//

import Moya

enum LocationAPI {

  case loadLocation(locationId: Int)

}

extension LocationAPI: TargetType {

  var path: String {
    switch self {
    case .loadLocation(let locationId):
      return "/location/\(locationId)"
    }
  }

  var method: Moya.Method {
    .get
  }

  var task: Task {
    switch self {
    case .loadLocation:
      return .requestPlain
    }
  }

}
