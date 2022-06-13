//
//  CharacterStatusTest.swift
//  RickAndMortySpecies Tests
//
//  Created by Dzmitry Kaminski on 5/23/22.
//

@testable import RickAndMortySpecies

import XCTest

class CharacterStatusTest: XCTestCase {

  func testAliveStatusValue() {
    let status = CharacterStatus.alive

    XCTAssert(status.value == Strings.statusAlive)
  }

  func testDeadStatusValue() {
    let status = CharacterStatus.dead

    XCTAssert(status.value == Strings.statusDead)
  }

  func testUnknownStatusValue() {
    let status = CharacterStatus.unknown

    XCTAssert(status.value == Strings.unknowStatus)
  }

  func testAliveStatusColor() {
    let status = CharacterStatus.alive

    XCTAssert(status.color == UIColor.systemGreen)
  }

  func testDeadStatusColor() {
    let status = CharacterStatus.dead

    XCTAssert(status.color == UIColor.systemRed)
  }

  func testUnknownStatusColor() {
    let status = CharacterStatus.unknown

    XCTAssert(status.color == UIColor.systemGray)
  }

}
