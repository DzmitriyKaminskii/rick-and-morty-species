//
//  Coordinator.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

protocol Coordinator: AnyObject, DeeplinkCoordinatorProtocol {

  var childCoordinators: [Coordinator] { get }
  var parent: Coordinator? { get set }

  func start()

  func add(child newChildCoordinator: Coordinator)
  func remove(child childCoordinator: Coordinator)

}
