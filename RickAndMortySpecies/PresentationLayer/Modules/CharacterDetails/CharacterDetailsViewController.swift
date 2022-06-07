//
//  CharacterDetailsViewController.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import RxCocoa
import RxSwift
import RxSwiftExt

class CharacterDetailsViewController: BindableViewController<CharacterDetailsViewModel>, ErrorShowing {

  @IBOutlet private var photoImageView: UIImageView!
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var speciesTitleLabel: UILabel!
  @IBOutlet private var speciesValueLabel: UILabel!
  @IBOutlet private var genderTitleLabel: UILabel!
  @IBOutlet private var genderValueLabel: UILabel!
  @IBOutlet private var statusView: StatusView!
  @IBOutlet private var locationTitleLabel: UILabel!
  @IBOutlet private var locationView: CharacterLocationView!

  override func viewDidLoad() {
    let backButton = UIBarButtonItem(title: Strings.closeButton,
                                     style: .plain,
                                     target: nil,
                                     action: nil)
    navigationItem.leftBarButtonItem = backButton

    super.viewDidLoad()
  }

  override func bind() {
    super.bind()

    locationView.updateViewModel(viewModel.locationViewModel)

    navigationItem.leftBarButtonItem?.rx.tap
      .bind(to: viewModel.input.closeDidTap)
      .disposed(by: disposeBag)

    viewModel.output.photo
      .unwrap()
      .emit(to: photoImageView.rx.alamofireImage)
      .disposed(by: disposeBag)

    viewModel.output.name
      .emit(to: nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.species
      .emit(to: speciesValueLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.gender
      .emit(to: genderValueLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.status
      .emit(to: statusView.rx.status)
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
    speciesTitleLabel.text = Strings.speciesTitle
    genderTitleLabel.text = Strings.genderTitle
    locationTitleLabel.text = Strings.locationTitle
  }

}
