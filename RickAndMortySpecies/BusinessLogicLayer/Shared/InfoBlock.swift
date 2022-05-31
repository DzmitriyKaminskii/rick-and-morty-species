//
//  InfoBlock.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

struct InfoBlock: Decodable, Equatable {

  let count: Int
  let pages: Int
  let next: String?
  let prev: String?

  static func == (lhs: InfoBlock, rhs: InfoBlock) -> Bool {
    lhs.count == rhs.count &&
    lhs.pages == rhs.pages &&
    lhs.next == rhs.next &&
    lhs.prev == rhs.prev
  }

}
