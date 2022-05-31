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

    static let successfulResponse = "characterListResponse"
    static let failResponse = "error"

  }

  private var repositoryTester: RepositoryTester!

  override func setUpWithError() throws {
    try super.setUpWithError()

    repositoryTester = RepositoryTester()
  }

  func testSuccessfulListCharacter() {
    repositoryTester.testSuccessfulResponse(ofType: CharacterListResponse.self,
                                            fromRepository: getRepository(jsonName: Constants.successfulResponse),
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

  private func getRepository(jsonName: String) -> CharacterRepositoryProtocol {
    let provider = RickAndMortyMoyaProvider<CharacterAPI> { character in
      switch character {
      case .characterList:
        return JSONUtils.dataFromJson(named: jsonName)
      }
    }

    return CharacterRepository(provider: provider)
  }

}
