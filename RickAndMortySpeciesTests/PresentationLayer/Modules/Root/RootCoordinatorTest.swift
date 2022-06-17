// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_unwrapping
//
//  RootCoordinatorTest.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/16/22.
//

@testable import RickAndMortySpecies

import XCTest
import RxSwift
import RxCocoa
import RxTest

class RootCoordinatorTest: XCTestCase {

  private enum Constants {

    static let queryString = "id=4"

  }

  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!

  private var coordinator: RootCoordinator!
  private var linkData: LinkData!
  private var failLinkData: LinkData!

  override func setUpWithError() throws {
    try super.setUpWithError()

    let window = UIWindow()

    coordinator = RootCoordinator(window: window)

    linkData = LinkData(type: LinkType.characterDetails, queryString: Constants.queryString)
    failLinkData = LinkData(type: LinkType.characterDetails, queryString: nil)

    coordinator.start()
    scheduler = TestScheduler(initialClock: 0)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()

    coordinator = nil
  }

  func testHandlerUrlWithSuccessfulData() {
    XCTAssert(coordinator.childCoordinators.first!.childCoordinators.isEmpty)
    coordinator.handleLink(linkData)
    XCTAssert(coordinator.childCoordinators.first!.childCoordinators.count == 1)
  }

  func testHandlerUrlWithFailData() {
    XCTAssert(coordinator.childCoordinators.first!.childCoordinators.isEmpty)
    coordinator.handleLink(failLinkData)
    XCTAssertFalse(coordinator.childCoordinators.first!.childCoordinators.count == 1)
  }
}
