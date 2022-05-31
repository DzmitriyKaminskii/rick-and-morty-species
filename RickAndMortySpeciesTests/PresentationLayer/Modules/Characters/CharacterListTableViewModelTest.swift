// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_unwrapping
// swiftlint:disable force_try
//
//  CharacterListTableViewModelTest.swift
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
import RxBlocking

class CharacterListTableViewModelTest: XCTestCase {

  private enum Constants {

    static let cellViewModelCount = 1
    static let successfulResponse = "characterListResponse"
    static let failResponse = "error"

  }

  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!

  override func setUpWithError() throws {
    try super.setUpWithError()

    scheduler = TestScheduler(initialClock: 0)
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

  func testViewModelCellViewModels() {
    let viewModel = getViewModel(jsonName: Constants.successfulResponse)
    viewModel.bind()

    let cellViewModels = try! viewModel.output.cellViewModels.toBlocking().first()!

    XCTAssertEqual(cellViewModels.count, Constants.cellViewModelCount)
  }

  func testViewModelError() {
    let viewModel = getViewModel(jsonName: Constants.failResponse)
    let errorMessage = scheduler.createObserver(String.self)

    viewModel.errors
      .bind(to: errorMessage)
      .disposed(by: disposeBag)

    viewModel.bind()

    XCTAssertEqual(errorMessage.events, [.next(0, TestHelperUtils.Constants.errorMessage)])
  }

  private func getViewModel(jsonName: String) -> CharacterListTableViewModel {
    let provider = RickAndMortyMoyaProvider<CharacterAPI> { character in
      switch character {
      case .characterList:
        return JSONUtils.dataFromJson(named: jsonName)
      }
    }

    return CharacterListTableViewModel(characterRepository: CharacterRepository(provider: provider))
  }

}
