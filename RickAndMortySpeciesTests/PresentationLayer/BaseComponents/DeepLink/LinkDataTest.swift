// swiftlint:disable force_unwrapping
//  LinkDataTest.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/13/22.
//

@testable import RickAndMortySpecies

import XCTest

class LinkDataTest: XCTestCase {

  private enum Constants {

    static let queryString = "character=2&id=4"
    static let characterKey = "character"
    static let characterValue = "2"
    static let idKey = "id"
    static let idValue = "4"

  }

  func testLinkData() {
    let linkData = LinkData(type: LinkType.characterDetails, queryString: Constants.queryString)

    XCTAssert(linkData.type == LinkType.characterDetails)
    XCTAssert(linkData.queryParams![Constants.characterKey] == Constants.characterValue)
    XCTAssert(linkData.queryParams![Constants.idKey] == Constants.idValue)
  }

}
