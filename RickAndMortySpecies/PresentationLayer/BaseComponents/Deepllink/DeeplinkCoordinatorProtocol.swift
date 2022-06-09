//
//  DeeplinkCoordinatorProtocol.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 6/9/22.
//

import Foundation

protocol DeeplinkCoordinatorProtocol {

  func canHandleLink(linkType: LinkType) -> Bool

  func handleLink(_ linkData: LinkData)

}
