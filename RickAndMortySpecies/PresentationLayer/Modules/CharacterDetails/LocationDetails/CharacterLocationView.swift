//
//  CharacterLocationView.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import RxSwift
import RxCocoa

class CharacterLocationView: XibLoadableView, ErrorShowing {

  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var typeTitleLabel: UILabel!
  @IBOutlet private var typeValueLabel: UILabel!
  @IBOutlet private var dimensionTitleLabel: UILabel!
  @IBOutlet private var dimensionValueLabel: UILabel!

  private var viewModel: CharacterLocationViewModel {
    guard let viewModel: CharacterLocationViewModel = viewModel() else {
      fatalError("Did you forget to set CharacterLocationViewModel?")
    }
    return viewModel
  }

  override func bind() {
    super.bind()

    viewModel.output.name
      .drive(nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.type
      .drive(typeValueLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.dimension
      .drive(dimensionValueLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.isLoaderShown
      .drive(LoadingView.rx.isActivityIndicatorShown(inView: self))
      .disposed(by: disposeBag)

    viewModel.errors
      .observeOnMain()
      .subscribe(onNext: { [weak self] message in self?.showError(message: message) })
      .disposed(by: disposeBag)
  }

  override func style() {
    typeTitleLabel.text = NSLocalizedString("location_type", comment: "")
    dimensionTitleLabel.text = NSLocalizedString("location_dimension", comment: "")
  }

}
