//
//  BindableTableViewController.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import UIKit

import RxSwift

class BindableTableViewController<ViewModelType: Bindable>: UITableViewController, Bindable, Styleable {

  private(set) var disposeBag: DisposeBag = DisposeBag()

  private var _viewModel: ViewModelType?

  var viewModel: ViewModelType {
    get {
      guard let viewModel = _viewModel else {
        fatalError("Did you forget to set \(String(describing: ViewModelType.self))?")
      }
      return viewModel
    }
    set { _viewModel = newValue }
  }

  override  func viewDidLoad() {
    super.viewDidLoad()
    self.style()
    self.bind()
  }

  func updateViewModel(_ viewModel: ViewModelType?) {
    self._viewModel = viewModel
  }

  func style() {}

  func bind() {
    viewModel.bind()
  }

  func unbind() {
    viewModel.unbind()
    disposeBag = DisposeBag()
  }

}
