//
//  TestHelperUtils.swift
//  RickAndMortySpecies Tests
//
//  Created by Dzmitry Kaminski on 5/22/22.
//

@testable import RickAndMortySpecies
import Foundation

enum TestHelperUtils {

  enum Constants {
    static let errorMessage = "There is nothing here."
  }

  static func getListCharacter() -> CharacterListResponse {
    let original = CharacterLocation(
      name: "Earth (Replacement Dimension)",
      url: "https://rickandmortyapi.com/api/location/20"
    )

    let location = CharacterLocation(
      name: "Testicle Monster Dimension",
      url: "https://rickandmortyapi.com/api/location/21"
    )

    let character = Character(
      id: 7,
      name: "Abradolf Lincler",
      status: CharacterStatus.unknown,
      species: "Human",
      type: "Genetic experiment",
      gender: CharacterGender.male,
      origin: original,
      location: location,
      image:  "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
      episode: ["https://rickandmortyapi.com/api/episode/10",
                "https://rickandmortyapi.com/api/episode/11"],
      url: "https://rickandmortyapi.com/api/character/7",
      created: "2017-11-04T19:59:20.523Z")

    let info = InfoBlock(
      count: 826,
      pages: 42,
      next: "https://rickandmortyapi.com/api/character?page=2",
      prev: nil
    )

    return CharacterListResponse(info: info, results: [character])
  }

  static func getLocation() -> Location {
    Location(
      id: 20,
      name: "Earth (Replacement Dimension)",
      type: "Planet",
      dimension: "Replacement Dimension",
      residents: [
        "https://rickandmortyapi.com/api/character/3",
        "https://rickandmortyapi.com/api/character/826"
      ],
      url: "https://rickandmortyapi.com/api/location/20",
      created: "2017-11-18T19:33:01.173Z"
    )
  }

}
