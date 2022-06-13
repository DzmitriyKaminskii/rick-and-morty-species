//
//  AlamofireImage.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/20/22.
//

import UIKit

import AlamofireImage

struct AlamofireImage {

  let url: URL?
  let placeholderImage: UIImage?
  let filter: ImageFilter?
  let transition: UIImageView.ImageTransition

  init(url: URL?,
       placeholderImage: UIImage? = nil,
       filter: ImageFilter? = nil,
       transition: UIImageView.ImageTransition = .noTransition) {
    self.url = url
    self.placeholderImage = placeholderImage
    self.filter = filter
    self.transition = transition
  }

}
