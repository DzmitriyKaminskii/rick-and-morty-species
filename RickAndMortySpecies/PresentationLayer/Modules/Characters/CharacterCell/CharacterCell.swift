//
//  CharacterCell.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterCell: BindableTableViewCell<CharacterCellViewModel> {

  @IBOutlet private var photoImageView: UIImageView!
  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var speciesLabel: UILabel!
  @IBOutlet private var genderLabel: UILabel!

  override func bind() {
    super.bind()

    guard let viewModel = viewModel else { return }

    viewModel.output.photo
      .drive(photoImageView.rx.alamofireImage)
      .disposed(by: disposeBag)

    viewModel.output.name
      .drive(nameLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.species
      .drive(speciesLabel.rx.text)
      .disposed(by: disposeBag)

    viewModel.output.gender
      .drive(genderLabel.rx.text)
      .disposed(by: disposeBag)

  }

  override func prepareForReuse() {
    super.prepareForReuse()

    photoImageView.image = nil
    nameLabel.text = nil
    speciesLabel.text = nil
    genderLabel.text = nil
  }

}
