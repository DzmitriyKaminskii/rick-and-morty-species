// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_unwrapping
//
//  CharacterDetailsViewModelCharacterIdTest.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/13/22.
//

@testable import RickAndMortySpecies
@testable import Moya

import XCTest
import RxSwift
import RxCocoa
import RxTest

class CharacterDetailsViewModelCharacterIdTest: XCTestCase {

  private enum Constants {

    static let characterId = 7

  }

  private var viewModel: CharacterDetailsViewModel!
  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!
  private var character: Character!
  private var location: Location!

  override func setUpWithError() throws {
    try super.setUpWithError()

    location = JSONUtils.decodeJson(named: "location")!
    character = JSONUtils.decodeJson(named: "character")!

    let locationProvider = RickAndMortyMoyaProvider<LocationAPI> { location in
      switch location {
      case .loadLocation(locationId: _):
        return JSONUtils.dataFromJson(named: "location")
      }
    }

    let characterProvider = RickAndMortyMoyaProvider<CharacterAPI> { character in
      switch character {
      case .characterList(pagination: _):
        return JSONUtils.dataFromJson(named: "characterListResponse")
      case .character(characterId: _):
        return JSONUtils.dataFromJson(named: "character")
      }
    }

    let locationRepository = LocationRepository(provider: locationProvider)
    let characterRepository = CharacterRepository(provider: characterProvider)

    viewModel = CharacterDetailsViewModel(
      characterId: Constants.characterId,
      locationRepository: locationRepository,
      characterRepository: characterRepository)

    let mockCoordinatorInput = CharacterDetailsCoordinatorInputMock()
    viewModel.updateCoordinator(mockCoordinatorInput)

    viewModel.bind()
    viewModel.locationViewModel.bind()

    scheduler = TestScheduler(initialClock: 0)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()

    viewModel.unbind()
    viewModel = nil
  }

  func testViewModelName() {
    let nameObserver = scheduler.createObserver(Optional<String>.self)

    viewModel.output.name
      .drive(nameObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(nameObserver.events, [.next(0, character.name)])
  }

  func testViewModelSpecies() {
    let speciesObserver = scheduler.createObserver(Optional<String>.self)

    viewModel.output.species
      .drive(speciesObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(speciesObserver.events, [.next(0, character.species)])
  }

  func testViewModelGender() {
    let genderObserver = scheduler.createObserver(Optional<String>.self)

    viewModel.output.gender
      .drive(genderObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(genderObserver.events, [.next(0, character.gender.value)])
  }

  func testViewModelStatus() {
    let statusObserver = scheduler.createObserver(Optional<CharacterStatus>.self)

    viewModel.output.status
      .drive(statusObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(statusObserver.events, [.next(0, character.status)])
  }

  func testInnerViewModel() {
    let nameObserver = scheduler.createObserver(Optional<String>.self)
    let typeObserver = scheduler.createObserver(Optional<String>.self)
    let dimensionObserver = scheduler.createObserver(Optional<String>.self)
    let isLoaderShownObserver = scheduler.createObserver(Bool.self)

    viewModel.locationViewModel.output.name
      .drive(nameObserver)
      .disposed(by: disposeBag)

    viewModel.locationViewModel.output.type
      .drive(typeObserver)
      .disposed(by: disposeBag)

    viewModel.locationViewModel.output.dimension
      .drive(dimensionObserver)
      .disposed(by: disposeBag)

    viewModel.locationViewModel.output.isLoaderShown
      .drive(isLoaderShownObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(nameObserver.events, [.next(0, location.name)])
    XCTAssertEqual(typeObserver.events, [.next(0, location.type)])
    XCTAssertEqual(dimensionObserver.events, [.next(0, location.dimension)])
    XCTAssertEqual(isLoaderShownObserver.events, [.next(0, false)])
  }

}
