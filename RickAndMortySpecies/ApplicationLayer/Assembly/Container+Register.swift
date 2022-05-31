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
    storyboardName: String,
    storyboardId: String,
    update: @escaping (Resolver, Service, Coordinator, CoordinatorParameter?) -> Void
  ) -> ServiceEntry<Service> {

    register(serviceType) { (resolver, coordinator: Coordinator, coordinatorParameter: CoordinatorParameter?) in
      let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
      guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId)
              as? Service else {
        fatalError("Expected class \(Service.self).")
      }
      update(resolver, viewController, coordinator, coordinatorParameter)
      return viewController
    }
  }

  @discardableResult
  func register<Service: UIViewController, Coordinator: CoordinatorInput>(
    _ serviceType: Service.Type,
    storyboardName: String,
    storyboardId: String,
    update: @escaping (Resolver, Service, Coordinator) -> Void
  ) -> ServiceEntry<Service> {

    register(serviceType) { (resolver, coordinator: Coordinator) in
      let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
      guard let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId)
              as? Service else {
        fatalError("Expected class \(Service.self).")
      }
      update(resolver, viewController, coordinator)
      return viewController
    }
  }

}

extension Resolver {

  func resolve<Service, Coordinator: CoordinatorInput, CoordinatorParameter>(
    _ serviceType: Service.Type,
    coordinator: Coordinator,
    coordinatorParameter: CoordinatorParameter? = nil)
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
