// swiftlint:disable implicitly_unwrapped_optional
//
//  CharacterRepositoryTest.swift
//  RickAndMortySpecies Tests
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

@testable import RickAndMortySpecies
@testable import Moya

import XCTest
import RxSwift
import RxCocoa
import RxTest

class CharacterRepositoryTest: XCTestCase {

  private enum Constants {

    static let successfulListResponse = "characterListResponse"
    static let successfulSingleResponse = "character"
    static let failResponse = "error"
    static let characterId = 7

  }

  private var repositoryTester: RepositoryTester!

  override func setUpWithError() throws {
    try super.setUpWithError()

    repositoryTester = RepositoryTester()
  }

  func testSuccessfulListCharacter() {
    repositoryTester.testSuccessfulResponse(ofType: CharacterListResponse.self,
                                            fromRepository: getRepository(jsonName: Constants.successfulListResponse),
                                            expectedResponse: TestHelperUtils.getListCharacter()) { repository in
      repository.loadCharacterList(pagination: PaginationParams(page: nil))
        .asObservable()
    }
  }

  func testFaildListCharacter() {
    let error = MoyaError.underlying(
      RickAndMortyAPIError.response(message: TestHelperUtils.Constants.errorMessage), nil)

    repositoryTester.testFailedResponse(ofType: CharacterListResponse.self,
                                        fromRepository: getRepository(jsonName: Constants.failResponse),
                                        expectedError: error) { repository in
      repository.loadCharacterList(pagination: PaginationParams(page: nil))
        .asObservable()
    }
  }

  func testSuccessfulCharacter() {
    repositoryTester.testSuccessfulResponse(ofType: Character.self,
                                            fromRepository: getRepository(jsonName: Constants.successfulSingleResponse),
                                            expectedResponse: TestHelperUtils.getCharacter()) { repository in
      repository.loadCharacter(id: Constants.characterId).asObservable()
    }
  }

  func testFaildCharacter() {
    let error = MoyaError.underlying(
      RickAndMortyAPIError.response(message: TestHelperUtils.Constants.errorMessage), nil)

    repositoryTester.testFailedResponse(ofType: Character.self,
                                        fromRepository: getRepository(jsonName: Constants.failResponse),
                                        expectedError: error) { repository in
      repository.loadCharacter(id: Constants.characterId).asObservable()
    }
  }

  private func getRepository(jsonName: String) -> CharacterRepositoryProtocol {
    let provider = RickAndMortyMoyaProvider<CharacterAPI> { character in
      switch character {
      case .characterList, .character(characterId: _):
        return JSONUtils.dataFromJson(named: jsonName)
      }
    }

    return CharacterRepository(provider: provider)
  }

}
