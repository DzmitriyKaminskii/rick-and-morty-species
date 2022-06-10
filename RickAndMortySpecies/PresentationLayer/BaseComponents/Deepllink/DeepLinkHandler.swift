//
//  DeepLinkHandler.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 6/9/22.
//

import UIKit

class DeepLinkHandler: DeeplinkHandlerProtocol {

  private let coordinator: Coordinator

  init(coordinator: Coordinator) {
    self.coordinator = coordinator
  }

  func handlerURLContext(_ context: Set<UIOpenURLContext>) {
    guard let url = context.first?.url, let host = url.host else { return }

    handlerLink(url: url, host: host)
  }

  func handlerURLContext(_ context: UIOpenURLContext) {
    guard let host = context.url.host else { return }

    handlerLink(url: context.url, host: host)
  }

  private func handlerLink(url: URL, host: String) {
    let type = LinkType.allCases.first { $0.rawValue == host }

    if let linkType = type {
      coordinator.handleLink(LinkData(type: linkType, queryString: url.query))
    }
  }

}
