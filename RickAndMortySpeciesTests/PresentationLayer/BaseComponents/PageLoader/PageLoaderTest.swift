// swiftlint:disable implicitly_unwrapped_optional
//
//  PageLoaderTest.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/16/22.
//

@testable import RickAndMortySpecies

import XCTest
import RxSwift
import RxCocoa
import RxTest

class PageLoaderTest: XCTestCase {

  private var pageLoader: PageLoader!
  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!

  override func setUpWithError() throws {
    try super.setUpWithError()

    scheduler = TestScheduler(initialClock: 0)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()

  }

}
