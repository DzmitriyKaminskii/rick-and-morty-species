//
//  LocationRepositoryProtocol.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import RxSwift

protocol LocationRepositoryProtocol {

  func loadLocation(id: Int) -> Single<Location>

}
