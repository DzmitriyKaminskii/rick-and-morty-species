//
//  CharacterGenderTest.swift
//  RickAndMortySpeciesTests
//
//  Created by Dzmitry Kaminski on 6/13/22.
//

@testable import RickAndMortySpecies

import XCTest

class CharacterGenderTest: XCTestCase {

  func testCharacterGenderFemale() {
    let gender = CharacterGender.female

    XCTAssert(gender.value == Strings.genderFemale)
  }

  func testCharacterGenderMale() {
    let gender = CharacterGender.male

    XCTAssert(gender.value == Strings.genderMale)
  }

  func testCharacterGenderGenderless() {
    let gender = CharacterGender.genderless

    XCTAssert(gender.value == Strings.genderGenderless)
  }

  func testCharacterGenderUnknown() {
    let gender = CharacterGender.unknown

    XCTAssert(gender.value == Strings.unknownGender)
  }

}
