//
//  BindableView.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import UIKit

import RxSwift

class BindableView: UIView, Bindable, Styleable {

  private(set) var disposeBag: DisposeBag = DisposeBag()

  private var _viewModel: BindableViewModel?

  func updateViewModel(_ viewModel: BindableViewModel?) {
    if _viewModel != viewModel {
      self.unbind()
      _viewModel = viewModel

      self.style()

      guard _viewModel != nil else { return }
      self.bind()
    }
  }

  func viewModel<T>() -> T? { _viewModel as? T }

  func style() {}

  func bind() {
    _viewModel?.bind()
  }

  func unbind() {
    _viewModel?.unbind()
    _viewModel = nil
    disposeBag = DisposeBag()
  }

}
