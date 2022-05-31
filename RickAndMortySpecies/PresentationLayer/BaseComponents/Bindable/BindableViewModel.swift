//
//  BindableViewModel.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import RxSwift
import RxRelay
import Moya

class BindableViewModel: NSObject, Bindable {

  private(set) var disposeBag: DisposeBag = DisposeBag()
  private(set) var errorsRelay = PublishRelay<Error>()

  lazy var errors = errorsRelay
    .share(replay: 1, scope: .forever)
    .map { error -> String in
      let moyaError = (error as? MoyaError)
      let currentError = (moyaError?.errorUserInfo["NSUnderlyingError"] as? RickAndMortyAPIError)

      if let messageError = currentError {
        switch messageError {
        case .response(let message):
          return message
        }
      }

      return "Unknown error"
    }

  private weak var _coordinator: CoordinatorInput?

  func bind() {}

  func unbind() {
    disposeBag = DisposeBag()
  }

  func updateCoordinator(_ coordinator: CoordinatorInput?) {
    _coordinator = coordinator
  }

  func coordinator<T>() -> T {
    guard let coordinator = _coordinator as? T else {
      fatalError("Did you forget to set \(T.self)?")
    }
    return coordinator
  }

}

extension BindableViewModel {

  override func isEqual(_ object: Any?) -> Bool {
    if let object = object as? BindableViewModel {
      return self.hashValue == object.hashValue
    } else {
      return false
    }
  }

}
