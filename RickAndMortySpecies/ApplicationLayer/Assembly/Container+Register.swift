//
//  Container+Register.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/31/22.
//

import Swinject

extension Container {

  @discardableResult
  func register<Service: UIViewController, Coordinator: CoordinatorInput, CoordinatorParameter>(
    _ serviceType: Service.Type,
    viewController: SceneType<Service>,
    update: @escaping (Resolver, Service, Coordinator, CoordinatorParameter) -> Void
  ) -> ServiceEntry<Service> {

    register(serviceType) { (resolver, coordinator: Coordinator, coordinatorParameter: CoordinatorParameter) in
      let viewInstance = viewController.instantiate()
      update(resolver, viewInstance, coordinator, coordinatorParameter)
      return viewInstance
    }
  }

  @discardableResult
  func register<Service: UIViewController, Coordinator: CoordinatorInput>(
    _ serviceType: Service.Type,
    viewController: SceneType<Service>,
    update: @escaping (Resolver, Service, Coordinator) -> Void
) -> ServiceEntry<Service> {

    register(serviceType) { (resolver, coordinator: Coordinator) in
      let viewInstance = viewController.instantiate()
      update(resolver, viewInstance, coordinator)
      return viewInstance
    }
  }

}
