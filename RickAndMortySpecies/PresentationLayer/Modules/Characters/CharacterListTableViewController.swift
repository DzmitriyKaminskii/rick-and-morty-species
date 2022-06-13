//
//  CharacterListTableViewController.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import UIKit

import RxSwift

class CharacterListTableViewController: BindableTableViewController<CharacterListTableViewModel>, ErrorShowing {

  private lazy var cellTypeName: String = String(describing: CharacterCell.self)
  private var cellReuseIdentifier: String { cellTypeName }

  override func viewDidLoad() {
    tableView.dataSource = nil

    let bundle = Bundle(for: CharacterCell.self)
    let nib = UINib(nibName: cellReuseIdentifier, bundle: bundle)
    tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)

    super.viewDidLoad()
  }

  override func bind() {
    super.bind()

    let configureCell: (Int, CharacterCellViewModel, CharacterCell) -> Void = { _, viewModel, cell in
      viewModel.unbind()
      cell.viewModel = viewModel
    }

    tableView.rx.modelSelected(CharacterCellViewModel.self)
      .bind(to: viewModel.input.selectedItem)
      .disposed(by: disposeBag)

    tableView.rx.prefetchRows
      .bind(to: viewModel.input.prefetchRows)
      .disposed(by: disposeBag)

    viewModel.output.cellViewModels
      .drive(tableView.rx.items(cellIdentifier: cellReuseIdentifier, cellType: CharacterCell.self))(configureCell)
      .disposed(by: disposeBag)

    viewModel.output.isLoaderShown
      .drive(LoadingView.rx.isActivityIndicatorShown(inViewController: self))
      .disposed(by: disposeBag)

    viewModel.errors
      .observeOnMain()
      .subscribe(onNext: { [weak self] message in self?.showError(message: message) })
      .disposed(by: disposeBag)
  }

  override func style() {
    self.navigationItem.title = Strings.characterListTitle
  }

}
