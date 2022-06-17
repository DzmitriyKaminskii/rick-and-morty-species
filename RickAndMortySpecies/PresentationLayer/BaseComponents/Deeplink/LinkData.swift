//
//  LinkData.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 6/8/22.
//

import Foundation

struct LinkData {
  let type: LinkType
  let queryParams: [String: String]?

  init(type: LinkType, queryString: String?) {
    self.type = type
    let params = queryString?.split(separator: "&")

    queryParams = params?.reduce(into: [String: String](), { result, element in
      let tuple = element.split(separator: "=")
      result.updateValue(String(tuple[1]), forKey: String(tuple[0]))
    })
  }

}
