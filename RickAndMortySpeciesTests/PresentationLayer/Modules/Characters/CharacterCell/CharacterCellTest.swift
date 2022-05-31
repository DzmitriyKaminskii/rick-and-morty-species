// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_unwrapping
//
//  CharacterCellTest.swift
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

class CharacterCellTest: XCTestCase {

  private enum Constants {
    static let id = 10
  }

  private var viewModel: CharacterCellViewModel!
  private var disposeBag: DisposeBag = DisposeBag()
  private var scheduler: TestScheduler!
  private var character: Character!

  override func setUpWithError() throws {
    try super.setUpWithError()

    character = getCharacterFromFile()

    viewModel = CharacterCellViewModel(
      id: character.id,
      image: character.image,
      name: character.name,
      species: character.species,
      gender: character.gender)

    scheduler = TestScheduler(initialClock: 0)
  }

  override func tearDownWithError() throws {
    try super.tearDownWithError()

    viewModel = nil
  }

  func testViewModelId() {
    let idObserver = scheduler.createObserver(Int.self)

    viewModel.output.id
      .drive(idObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(idObserver.events, [.next(0, character.id), .completed(0)])
  }

  func testViewModelName() {
    let nameObserver = scheduler.createObserver(String.self)

    viewModel.output.name
      .drive(nameObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(nameObserver.events, [.next(0, character.name), .completed(0)])
  }

  func testViewModelSpecies() {
    let speciesObserver = scheduler.createObserver(String.self)

    viewModel.output.species
      .drive(speciesObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(speciesObserver.events, [.next(0, character.species), .completed(0)])
  }

  func testViewModelGender() {
    let genderObserver = scheduler.createObserver(String.self)

    viewModel.output.gender
      .drive(genderObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(genderObserver.events, [.next(0, character.gender.value), .completed(0)])
  }

  private func getCharacterFromFile() -> Character {
    JSONUtils.decodeJson(named: "character")!
  }

}
