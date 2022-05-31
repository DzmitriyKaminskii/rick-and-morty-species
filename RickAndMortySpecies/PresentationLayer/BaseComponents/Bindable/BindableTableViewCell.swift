//
//  BindableTableViewCell.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import UIKit

import RxSwift

class BindableTableViewCell<ViewModelType: BindableViewModel>: UITableViewCell, Bindable, Styleable {

  private(set) var disposeBag: DisposeBag = DisposeBag()

  private var _viewModel: ViewModelType?
  var viewModel: ViewModelType? {
    get { _viewModel }
    set {
      _viewModel = newValue

      guard _viewModel != nil else { return }
      bind()
      style()
    }
  }

  override  func prepareForReuse() {
    super.prepareForReuse()
    unbind()
    viewModel = nil
  }

  func style() {}

  func bind() {
    viewModel?.bind()
  }

  func unbind() {
    viewModel?.unbind()
    disposeBag = DisposeBag()
  }

}
