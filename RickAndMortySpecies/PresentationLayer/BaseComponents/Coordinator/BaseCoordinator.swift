//
//  BaseCoordinator.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import RxSwift
import RxCocoa
import RxSwiftExt

class BaseCoordinator<FinishType>: NSObject, Coordinator {

  private(set) var childCoordinators: [Coordinator] = []
  weak var parent: Coordinator?

  let finishedRelay = PublishRelay<FinishType>()
  lazy var finished = finishedRelay.asSignal()

  private(set) var disposeBag = DisposeBag()

  func start() {
    disposeBag = DisposeBag()
  }

  func handleLink(_ linkData: LinkData) {}
  func canHandleLink(linkType: LinkType) -> Bool { false }

  func add(child newChildCoordinator: Coordinator) {
    newChildCoordinator.parent = self
    childCoordinators.append(newChildCoordinator)
  }

  func remove(child childCoordinator: Coordinator) {
    childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    childCoordinator.parent = nil
  }

}

extension BaseCoordinator: Navigatable {

  func navigate<T>(to targetCoordinator: BaseCoordinator<T>) -> Single<T> {
    add(child: targetCoordinator)
    targetCoordinator.start()

    return targetCoordinator.finished
      .asObservable()
      .do(onDispose: { [weak self, weak targetCoordinator] in
        guard let targetCoordinator = targetCoordinator else { return }
        self?.remove(child: targetCoordinator)
      })
        .map { $0 as T }
        .unwrap()
        .take(1)
        .asSingle()
  }

}
