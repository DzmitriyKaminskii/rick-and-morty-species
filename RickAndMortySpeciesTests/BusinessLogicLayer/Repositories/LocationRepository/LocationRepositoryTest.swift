// swiftlint:disable implicitly_unwrapped_optional
//
//  LocationRepositoryTest.swift
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

class LocationRepositoryTest: XCTestCase {

  private enum Constants {

    static let locationId = 20
    static let successfulResponse = "location"
    static let failResponse = "error"

  }

  private var repositoryTester: RepositoryTester!

  override func setUpWithError() throws {
    try super.setUpWithError()

    repositoryTester = RepositoryTester()
  }

  func testSuccessfulLocation() {
    repositoryTester.testSuccessfulResponse(ofType: Location.self,
                                            fromRepository: getRepository(jsonName: Constants.successfulResponse),
                                            expectedResponse: TestHelperUtils.getLocation()) { repository in
      repository.loadLocation(id: Constants.locationId)
        .asObservable()
    }
  }

  func testFailLocation() {
    let error = MoyaError.underlying(
      RickAndMortyAPIError.response(message: TestHelperUtils.Constants.errorMessage), nil)

    repositoryTester.testFailedResponse(ofType: Location.self,
                                        fromRepository: getRepository(jsonName: Constants.failResponse),
                                        expectedError: error) { repository in
      repository.loadLocation(id: Constants.locationId)
        .asObservable()
    }
  }

  private func getRepository(jsonName: String) -> LocationRepositoryProtocol {
    let provider = RickAndMortyMoyaProvider<LocationAPI> { location in
      switch location {
      case .loadLocation(locationId: _):
        return JSONUtils.dataFromJson(named: jsonName)
      }
    }

    return LocationRepository(provider: provider)
  }

}
