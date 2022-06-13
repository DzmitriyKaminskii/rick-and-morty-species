//
//  CharacterAPITest.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/13/22.
//

@testable import RickAndMortySpecies

import XCTest
import Moya

class CharacterAPITest: XCTestCase {

  func testLoadCharacterList() {
    let characterAPI = CharacterAPI.characterList(pagination: PaginationParams(page: nil))

    XCTAssert(characterAPI.path == "/character")
    XCTAssert(characterAPI.method == .get)
  }

  func testLoadCharacter() {
    let characterId = 5
    let characterAPI = CharacterAPI.character(characterId: characterId)

    XCTAssert(characterAPI.path == "/character/\(characterId)")
    XCTAssert(characterAPI.method == .get)
  }

}
