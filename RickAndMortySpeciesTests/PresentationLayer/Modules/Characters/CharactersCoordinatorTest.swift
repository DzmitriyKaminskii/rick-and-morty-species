// swiftlint:disable implicitly_unwrapped_optional
//
//  CharactersCoordinatorTest.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/16/22.
//

@testable import RickAndMortySpecies

import XCTest
import RxSwift
import RxCocoa
import RxTest

class CharactersCoordinatorTest: XCTestCase {

  private enum Constants {

    static let queryString = "id=4"

  }

  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!

  private var coordinator: CharactersCoordinator!
  private var linkData: LinkData!

  override func setUpWithError() throws {
    try super.setUpWithError()

    let rootViewController = UINavigationController(rootViewController: UIViewController())

    coordinator = CharactersCoordinator(rootViewController: rootViewController)

    linkData = LinkData(type: LinkType.characterDetails, queryString: Constants.queryString)

    coordinator.start()
    scheduler = TestScheduler(initialClock: 0)
  }

  func testCanHandlerUrl() {
    XCTAssert(coordinator.canHandleLink(linkType: linkData.type))
  }

  func testHandlerUrl() {
    XCTAssert(coordinator.childCoordinators.isEmpty)
    coordinator.handleLink(linkData)
    XCTAssert(coordinator.childCoordinators.count == 1)
  }

}
