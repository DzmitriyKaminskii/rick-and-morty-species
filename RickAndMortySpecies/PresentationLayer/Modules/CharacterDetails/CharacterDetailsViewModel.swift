//
//  CharacterDetailsViewModel.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import Action
import AlamofireImage

import RxSwift
import RxCocoa

class CharacterDetailsViewModel: BindableViewModel {

  struct Input {
    let closeDidTap = PublishRelay<Void>()
  }

  struct Output {
    let photo: Driver<AlamofireImage?>
    let name: Driver<String?>
    let species: Driver<String?>
    let gender: Driver<String?>
    let status: Driver<CharacterStatus?>
    let isLoaderShown: Driver<Bool>
  }

  let input = Input()
  let output: Output

  let locationViewModel: CharacterLocationViewModel

  private var coordinator: CharacterDetailsCoordinatorInput { coordinator() }
  private let characterRelay = BehaviorRelay<Character?>(value: nil)
  private let isLoaderShownRelay = BehaviorRelay<Bool>(value: false)

  private let characterInitRelay: BehaviorRelay<Character>?
  private let characterIdRelay: BehaviorRelay<Int>?

  private let locationRepository: LocationRepositoryProtocol
  private let characterRepository: CharacterRepositoryProtocol?

  private lazy var loadCharacterAction = Action<Int, Character> { [weak self] characterId in
    guard let self = self, let repository = self.characterRepository else { return .empty() }
    return repository.loadCharacter(id: characterId).asObservable()
  }

  convenience init(character: Character, locationRepository: LocationRepositoryProtocol) {
    self.init(locationRepository: locationRepository, characterInitRelay: BehaviorRelay(value: character))
  }

  convenience init(characterId: Int,
                   locationRepository: LocationRepositoryProtocol,
                   characterRepository: CharacterRepositoryProtocol) {
    self.init(locationRepository: locationRepository,
              characterRepository: characterRepository,
              characterIdRelay: BehaviorRelay(value: characterId))
  }

  private init(locationRepository: LocationRepositoryProtocol,
               characterRepository: CharacterRepositoryProtocol? = nil,
               characterInitRelay: BehaviorRelay<Character>? = nil,
               characterIdRelay: BehaviorRelay<Int>? = nil) {
    self.characterRepository = characterRepository
    self.locationRepository = locationRepository
    self.characterInitRelay = characterInitRelay
    self.characterIdRelay = characterIdRelay

    let locationId = characterRelay.asDriver()
      .map { CharacterLinkComponents.getLocationId(by: $0?.location.url) }

    locationViewModel = CharacterLocationViewModel(locationId: locationId, locationRepository: locationRepository)

    let photo = characterRelay
      .asDriver()
      .map { character -> AlamofireImage? in
        let photoUrl = URL(string: character?.image ?? "")
        let placeholder = Image(named: "no_image", in: Bundle.main, compatibleWith: nil)
        return AlamofireImage(url: photoUrl, placeholderImage: placeholder)
      }

    output = Output(
      photo: photo,
      name: characterRelay.asDriver().map { $0?.name },
      species: characterRelay.asDriver().map { $0?.species },
      gender: characterRelay.asDriver().map { $0?.gender.value },
      status: characterRelay.asDriver().map { $0?.status },
      isLoaderShown: isLoaderShownRelay.asDriver()
    )
  }

  override func bind() {
    loadCharacterAction.elements
      .bind(to: characterRelay)
      .disposed(by: disposeBag)

    loadCharacterAction.executing
      .bind(to: isLoaderShownRelay)
      .disposed(by: disposeBag)

    loadCharacterAction.underlyingError
      .bind(to: errorsRelay)
      .disposed(by: disposeBag)

    input.closeDidTap
      .bind(to: coordinator.close())
      .disposed(by: disposeBag)

    characterInitRelay?
      .bind(to: characterRelay)
      .disposed(by: disposeBag)

    characterIdRelay?
      .bind(to: loadCharacterAction.inputs)
      .disposed(by: disposeBag)
  }

}
