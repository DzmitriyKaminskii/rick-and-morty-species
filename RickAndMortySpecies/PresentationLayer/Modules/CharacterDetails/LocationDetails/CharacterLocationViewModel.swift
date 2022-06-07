//
//  CharacterLocationViewModel.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import Action
import RxSwift
import RxCocoa

class CharacterLocationViewModel: BindableViewModel {

  struct Output {
    let name: Driver<String?>
    let type: Driver<String?>
    let dimension: Driver<String?>
    let isLoaderShown: Driver<Bool>
  }

  let output: Output

  private let locationRepository: LocationRepositoryProtocol
  private let locationId: Signal<Int?>
  private var locationRelay = BehaviorRelay<Location?>(value: nil)
  private let isLoaderShownRelay = BehaviorRelay<Bool>(value: false)

  private lazy var loadLocationAction = Action<Int, Location> { [weak self] locationId in
    guard let self = self else { return .empty() }
    return self.locationRepository.loadLocation(id: locationId)
      .asObservable()
  }

  init(locationId: Signal<Int?>, locationRepository: LocationRepositoryProtocol) {
    self.locationRepository = locationRepository
    self.locationId = locationId

    let name = locationRelay.map { $0?.name }.asDriver(onErrorJustReturn: nil)
    let type = locationRelay.map { $0?.type }.asDriver(onErrorJustReturn: nil)
    let dimension = locationRelay.map { $0?.dimension ?? "" }.asDriver(onErrorJustReturn: nil)

    output = Output(
      name: name,
      type: type,
      dimension: dimension,
      isLoaderShown: isLoaderShownRelay.asDriver()
    )
  }

  override func bind() {
    loadLocationAction.elements
      .bind(to: locationRelay)
      .disposed(by: disposeBag)

    loadLocationAction.executing
      .bind(to: isLoaderShownRelay)
      .disposed(by: disposeBag)

    loadLocationAction.underlyingError
      .bind(to: errorsRelay)
      .disposed(by: disposeBag)

    locationId
      .unwrap()
      .emit(to: loadLocationAction.inputs)
      .disposed(by: disposeBag)
  }

}
