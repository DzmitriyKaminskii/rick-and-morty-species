// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_unwrapping
//
//  CharacterLocationViewModelTest.swift
//  RickAndMortySpecies Tests
//
//  Created by Dzmitry Kaminski on 5/22/22.
//

@testable import RickAndMortySpecies
@testable import Moya

import XCTest
import RxSwift
import RxCocoa
import RxTest

class CharacterLocationViewModelTest: XCTestCase {

  private enum Constants {

    static let successfulResponse = "location"
    static let failResponse = "error"

  }

  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!
  private var location: Location!

  override func setUpWithError() throws {
    try super.setUpWithError()

    location = generateLocationFromFile()
    scheduler = TestScheduler(initialClock: 0)
  }

  func testViewModelName() {
    let viewModel = getViewModel(jsonName: Constants.successfulResponse)
    viewModel.bind()

    let nameObserver = scheduler.createObserver(Optional<String>.self)

    viewModel.output.name
      .drive(nameObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(nameObserver.events, [.next(0, location.name)])
  }

  func testViewModelType() {
    let viewModel = getViewModel(jsonName: Constants.successfulResponse)
    viewModel.bind()

    let typeObserver = scheduler.createObserver(Optional<String>.self)

    viewModel.output.type
      .drive(typeObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(typeObserver.events, [.next(0, location.type)])
  }

  func testViewModelDimension() {
    let viewModel = getViewModel(jsonName: Constants.successfulResponse)
    viewModel.bind()

    let dimensionObserver = scheduler.createObserver(Optional<String>.self)

    viewModel.output.dimension
      .drive(dimensionObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(dimensionObserver.events, [.next(0, location.dimension)])
  }

  func testViewModelIsLoaderShown() {
    let viewModel = getViewModel(jsonName: Constants.successfulResponse)
    viewModel.bind()

    let isLoaderShownObserver = scheduler.createObserver(Bool.self)

    viewModel.output.isLoaderShown
      .drive(isLoaderShownObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(isLoaderShownObserver.events, [.next(0, false)])
  }

  func testViewModelError() {
    let viewModel = getViewModel(jsonName: Constants.failResponse)
    let errorObserver = scheduler.createObserver(String.self)

    viewModel.errors
      .bind(to: errorObserver)
      .disposed(by: disposeBag)

    viewModel.bind()

    XCTAssertEqual(errorObserver.events, [.next(0, TestHelperUtils.Constants.errorMessage)])
  }

  private func getViewModel(jsonName: String) -> CharacterLocationViewModel {
    let provider = RickAndMortyMoyaProvider<LocationAPI> { location in
      switch location {
      case .loadLocation(locationId: _):
        return JSONUtils.dataFromJson(named: jsonName)
      }
    }

    let repository = LocationRepository(provider: provider)

    return CharacterLocationViewModel(locationId: location.id, locationRepository: repository)
  }

  private func generateLocationFromFile() -> Location {
    JSONUtils.decodeJson(named: "location")!
  }

}
