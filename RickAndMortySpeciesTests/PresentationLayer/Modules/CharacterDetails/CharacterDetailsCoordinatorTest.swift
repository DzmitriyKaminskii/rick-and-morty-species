// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_unwrapping
//
//  CharacterDetailsCoordinatorTest.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/16/22.
//

@testable import RickAndMortySpecies
@testable import Moya

import XCTest
import RxSwift
import RxCocoa
import RxTest

class CharacterDetailsCoordinatorTest: XCTestCase {

  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!

  override func setUpWithError() throws {
    try super.setUpWithError()

    scheduler = TestScheduler(initialClock: 0)
  }

  func testCloseActionWithCharacter() {
    let rootViewController = UINavigationController(rootViewController: UIViewController())

    let coordinator = CharacterDetailsCoordinator(
      rootViewController: rootViewController,
      character: JSONUtils.decodeJson(named: "character")!)

    coordinator.start()

    let coordinatorInput: CharacterDetailsCoordinatorInput = coordinator

    let closeObserver = scheduler.createObserver(Void.self)

    coordinator.finished
      .emit(to: closeObserver)
      .disposed(by: disposeBag)

    scheduler.createColdObservable([.next(0, ())])
      .bind(to: coordinatorInput.close())
      .disposed(by: disposeBag)

    scheduler.start()

    XCTAssertEqual(closeObserver.events.count, 1)
  }

  func testCloseActionWithCharacterId() {
    let rootViewController = UINavigationController(rootViewController: UIViewController())

    let coordinator = CharacterDetailsCoordinator(
      rootViewController: rootViewController,
      characterId: 5)

    coordinator.start()

    let coordinatorInput: CharacterDetailsCoordinatorInput = coordinator

    let closeObserver = scheduler.createObserver(Void.self)

    coordinator.finished
      .emit(to: closeObserver)
      .disposed(by: disposeBag)

    scheduler.createColdObservable([.next(0, ())])
      .bind(to: coordinatorInput.close())
      .disposed(by: disposeBag)

    scheduler.start()

    XCTAssertEqual(closeObserver.events.count, 1)
  }

}
