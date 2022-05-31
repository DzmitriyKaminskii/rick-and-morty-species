//
//  LocationAPITest.swift
//  RickAndMortySpecies Tests
//
//  Created by Dzmitry Kaminski on 5/24/22.
//

@testable import RickAndMortySpecies

import XCTest
import Moya

class LocationAPITest: XCTestCase {

  func testLoadLocation() {
    let locationId = 5
    let locationAPI = LocationAPI.loadLocation(locationId: locationId)

    XCTAssert(locationAPI.path == "/location/\(locationId)")
    XCTAssert(locationAPI.method == .get)
  }

}
