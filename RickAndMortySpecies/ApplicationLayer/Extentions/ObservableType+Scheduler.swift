//
//  ObservableType+Scheduler.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import RxSwift

extension ObservableType {

  public func observeOnMain() -> RxSwift.Observable<Self.Element> {
    self.observe(on: MainScheduler.instance)
  }

}
