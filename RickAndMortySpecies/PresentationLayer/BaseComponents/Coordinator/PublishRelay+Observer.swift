//
//  PublishRelay+Observer.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/22/22.
//

import RxSwift
import RxCocoa

extension AnyObserver {

  public init(_ relay: PublishRelay<Element>) {
    self.init { event in
      guard case let .next(value) = event else { return }
      relay.accept(value)
    }
  }

  public init(_ relay: BehaviorRelay<Element>) {
    self.init { event in
      guard case let .next(value) = event else { return }
      relay.accept(value)
    }
  }

}

extension PublishRelay {

  public func asObserver() -> AnyObserver<Element> {
    AnyObserver(self)
  }

}

extension BehaviorRelay {

  public func asObserver() -> AnyObserver<Element> {
    AnyObserver(self)
  }

}
