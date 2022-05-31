//
//  Navigatable.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import RxSwift

protocol Navigatable {

  func navigate<T>(to targetCoordinator: BaseCoordinator<T>) -> Single<T>

}
