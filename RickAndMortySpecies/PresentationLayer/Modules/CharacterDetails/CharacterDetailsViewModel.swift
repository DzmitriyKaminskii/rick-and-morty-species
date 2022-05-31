//
//  CharacterDetailsViewModel.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import RxSwift
import RxCocoa

import AlamofireImage

class CharacterDetailsViewModel: BindableViewModel {

  struct Input {
    let closeDidTap = PublishRelay<Void>()
  }

  struct Output {
    let photo: Driver<AlamofireImage>
    let name: Driver<String>
    let species: Driver<String>
    let gender: Driver<String>
    let status: Driver<CharacterStatus>
  }

  let input = Input()
  let output: Output

  private var coordinator: CharacterDetailsCoordinatorInput { coordinator() }
  private let character: Character
  let locationViewModel: CharacterLocationViewModel

  init(character: Character, locationRepository: LocationRepositoryProtocol) {
    self.character = character

    let linkComponent = CharacterLinkComponents(urlString: character.location.url)

    locationViewModel = CharacterLocationViewModel(locationId: linkComponent.locationId,
                                                   locationRepository: locationRepository)

    let photoUrl = URL(string: character.image)
    let placeholder = Image(named: "no_image", in: Bundle.main, compatibleWith: nil)
    let photo = AlamofireImage(url: photoUrl, placeholderImage: placeholder)

    output = Output(
      photo: .just(photo),
      name: .just(character.name),
      species: .just(character.species),
      gender: .just(character.gender.value),
      status: .just(character.status)
    )

    super.init()
  }

  override func bind() {
    input.closeDidTap
      .bind(to: coordinator.close())
      .disposed(by: disposeBag)
  }

}
