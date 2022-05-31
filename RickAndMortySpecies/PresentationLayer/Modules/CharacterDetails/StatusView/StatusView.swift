//
//  StatusView.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import Foundation
import UIKit

class StatusView: XibLoadableView {

  @IBOutlet private var titleLabel: UILabel!

  var status: CharacterStatus? {
    didSet {
      updateView(for: status ?? .unknown)
    }
  }

  private func updateView(for status: CharacterStatus) {
    titleLabel.text = status.value
    titleLabel.backgroundColor = status.color
  }
}
