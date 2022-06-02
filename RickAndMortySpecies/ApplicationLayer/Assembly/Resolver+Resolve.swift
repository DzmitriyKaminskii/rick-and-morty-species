//
//  Container+Resolver.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/31/22.
//

import Swinject

extension Resolver {

  func resolve<Service, Coordinator: CoordinatorInput, CoordinatorParameter>(
    _ serviceType: Service.Type,
    coordinator: Coordinator,
    coordinatorParameter: CoordinatorParameter)
  -> Service? {
    resolve(serviceType, arguments: coordinator, coordinatorParameter)
  }

  func resolve<Service, Coordinator: CoordinatorInput>(
    _ serviceType: Service.Type,
    coordinator: Coordinator)
  -> Service? {
    resolve(serviceType, argument: coordinator)
  }

}
