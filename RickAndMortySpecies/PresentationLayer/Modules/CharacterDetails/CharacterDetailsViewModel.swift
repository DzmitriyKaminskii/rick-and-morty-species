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
    let photo: Signal<AlamofireImage?>
    let name: Signal<String>
    let species: Signal<String>
    let gender: Signal<String>
    let status: Signal<CharacterStatus>
    let isLoaderShown: Driver<Bool>
  }

  let input = Input()
  let output: Output

  let locationViewModel: CharacterLocationViewModel

  private var coordinator: CharacterDetailsCoordinatorInput { coordinator() }
  private let characterRelay = BehaviorRelay<Character?>(value: nil)
  private let isLoaderShownRelay = BehaviorRelay<Bool>(value: false)

  private let locationRepository: LocationRepositoryProtocol
  private let characterRepository: CharacterRepositoryProtocol?

  private lazy var loadCharacterAction = Action<Int, Character> { [weak self] characterId in
    guard let self = self, let repository = self.characterRepository else { return .empty() }
    return repository.loadCharacter(id: characterId).asObservable()
  }

  convenience init(character: Character, locationRepository: LocationRepositoryProtocol) {
    self.init(locationRepository: locationRepository)
    self.characterRelay.accept(character)
  }

  convenience init(characterId: Int,
                   locationRepository: LocationRepositoryProtocol,
                   characterRepository: CharacterRepositoryProtocol) {
    self.init(locationRepository: locationRepository, characterRepository: characterRepository)

    self.loadCharacterAction.execute(characterId)
  }

  init(locationRepository: LocationRepositoryProtocol, characterRepository: CharacterRepositoryProtocol? = nil) {
    self.characterRepository = characterRepository
    self.locationRepository = locationRepository

    locationViewModel = CharacterLocationViewModel(
      locationId: characterRelay.map { CharacterLinkComponents.getLocationId(by: $0?.location.url ?? "") }
        .asSignal(onErrorRecover: { _ in .just(nil) }),
      locationRepository: locationRepository)

    let photo = characterRelay
      .map { character -> AlamofireImage? in
        let photoUrl = URL(string: character?.image ?? "")
        let placeholder = Image(named: "no_image", in: Bundle.main, compatibleWith: nil)
        return AlamofireImage(url: photoUrl, placeholderImage: placeholder)
      }
      .asSignal { _ in .just(nil) }

    output = Output(
      photo: photo,
      name: characterRelay.map { $0?.name ?? "" }
        .asSignal(onErrorRecover: { _ in .just("") }),
      species: characterRelay.map { $0?.species ?? "" }
        .asSignal(onErrorRecover: { _ in .just("") }),
      gender: characterRelay.map { $0?.gender.value ?? "" }
        .asSignal(onErrorRecover: { _ in .just("") }),
      status: characterRelay.map { $0?.status ?? CharacterStatus.unknown }
        .asSignal(onErrorRecover: { _ in .just(CharacterStatus.unknown) }),
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
  }

}
