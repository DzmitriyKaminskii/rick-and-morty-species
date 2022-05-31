//
//  LocationRepository.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import Moya
import RxSwift

class LocationRepository: LocationRepositoryProtocol {

  private let provider: RickAndMortyMoyaProvider<LocationAPI>

  convenience init() {
    let provider = RickAndMortyMoyaProvider<LocationAPI>()
    self.init(provider: provider)
  }

  init(provider: RickAndMortyMoyaProvider<LocationAPI>) {
    self.provider = provider
  }

  func loadLocation(id: Int) -> Single<Location> {
    let requestEndpoint = LocationAPI.loadLocation(locationId: id)
    return provider.request(requestEndpoint, responseType: Location.self)
  }

}
