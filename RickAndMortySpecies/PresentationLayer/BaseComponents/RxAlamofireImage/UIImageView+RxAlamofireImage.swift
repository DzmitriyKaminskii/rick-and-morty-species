//  swiftlint:disable:this file_name
//  UIImageView+RxAlamofireImage.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/20/22.
//

#if os(iOS) || os(tvOS)

import UIKit

import AlamofireImage
import RxSwift
import RxCocoa

extension Reactive where Base: UIImageView {

  var alamofireImage: Binder<AlamofireImage> {
    Binder(base) { imageView, image in
      guard let url = image.url else {
        imageView.image = image.placeholderImage
        return
      }
      imageView.af.setImage(withURL: url,
                            placeholderImage: image.placeholderImage,
                            filter: image.filter,
                            imageTransition: image.transition)
    }
  }

}

#endif
