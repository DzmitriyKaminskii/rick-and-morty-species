//
//  CharacterCellViewModel.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//
import AlamofireImage

import RxSwift
import RxCocoa

class CharacterCellViewModel: BindableViewModel {

  struct Output {
    let id: Driver<Int>
    let photo: Driver<AlamofireImage>
    let name: Driver<String>
    let species: Driver<String>
    let gender: Driver<String>
  }

  let output: Output

  init(id: Int,
       image: String,
       name: String,
       species: String,
       gender: CharacterGender) {
    let photoUrl = URL(string: image)
    let placeholder = Image(named: "no_image", in: Bundle.main, compatibleWith: nil)
    let photo = AlamofireImage(url: photoUrl, placeholderImage: placeholder)

    output = Output(
      id: .just(id),
      photo: .just(photo),
      name: .just(name),
      species: .just(species),
      gender: .just(gender.value))

    super.init()
  }

}
