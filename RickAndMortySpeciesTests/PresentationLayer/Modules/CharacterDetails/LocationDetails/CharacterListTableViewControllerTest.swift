// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_unwrapping
//
//  CharacterListTableViewControllerTest.swift
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

class CharacterListTableViewControllerTest: XCTestCase {

  private var viewController: CharacterDetailsViewController!
  private var viewModel: CharacterDetailsViewModel!
  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!
  private var character: Character!
  private var location: Location!

  override func setUpWithError() throws {
    try super.setUpWithError()

    character = JSONUtils.decodeJson(named: "character")!
    location = JSONUtils.decodeJson(named: "location")!

    let provider = RickAndMortyMoyaProvider<LocationAPI> { location in
      switch location {
      case .loadLocation(locationId: _):
        return JSONUtils.dataFromJson(named: "location")
      }
    }

    let repository = LocationRepository(provider: provider)

    viewModel = CharacterDetailsViewModel(
      character: character,
      locationRepository: repository)

    let mockCoordinatorInput = CharacterDetailsCoordinatorInputMock()
    viewModel.updateCoordinator(mockCoordinatorInput)

    viewController = StoryboardScene.Main.characterDetails.instantiate()
    viewController.updateViewModel(viewModel)
    viewController.loadViewIfNeeded()

    viewModel.bind()
    viewModel.locationViewModel.bind()

    scheduler = TestScheduler(initialClock: 0)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()

    viewModel.unbind()
    viewModel = nil
    viewController = nil
  }

  func testBackButtonTitle() {
    let title = viewController.navigationItem.leftBarButtonItem?.title

    XCTAssertEqual(title, Strings.closeButton)
  }
}
