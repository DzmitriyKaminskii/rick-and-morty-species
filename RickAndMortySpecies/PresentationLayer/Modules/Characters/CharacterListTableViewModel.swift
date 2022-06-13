//
//  CharacterListTableViewModel.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import UIKit

import Action
import RxCocoa
import RxSwift

class CharacterListTableViewModel: BindableViewModel {

  struct Input {
    let selectedItem: PublishRelay<CharacterCellViewModel> = PublishRelay()
    let prefetchRows = PublishRelay<[IndexPath]>()
  }

  struct Output {
    let cellViewModels: Driver<[CharacterCellViewModel]>
    let isLoaderShown: Driver<Bool>
  }

  let input = Input()
  let output: Output

  private var coordinator: CharactersCoordinatorInput { coordinator() }
  private let characterRepository: CharacterRepositoryProtocol
  private let cellViewModelsRelay = BehaviorRelay<[CharacterCellViewModel]>(value: [])
  private var charctersRelay = BehaviorRelay<[Character]>(value: [])
  private let isLoaderShownRelay = BehaviorRelay<Bool>(value: false)

  private let pageLoader = PageLoader()

  private lazy var loadCharactersAction = Action<Int, CharacterListResponse> { [weak self] page in
    guard let self = self else { return .empty() }
    return self.characterRepository.loadCharacterList(pagination: PaginationParams(page: page))
      .asObservable()
  }

  init(characterRepository: CharacterRepositoryProtocol) {
    self.characterRepository = characterRepository

    output = Output(
      cellViewModels: cellViewModelsRelay.asDriver(),
      isLoaderShown: isLoaderShownRelay.asDriver()
    )

    super.init()
  }

  override func bind() {
    bindAction()

    charctersRelay
      .map({ [weak self] characterList in
        guard let self = self else { return [] }
        return self.buildListCellViewModel(characterList: characterList)
      })
      .bind(to: cellViewModelsRelay)
      .disposed(by: disposeBag)

    input.selectedItem
      .map({ [weak self] cellViewModel in
        guard let self = self else { return }
        self.obtainSelectedCharacter(cellViewModel: cellViewModel)
      })
      .subscribe()
      .disposed(by: disposeBag)

    input.prefetchRows
      .withLatestFrom(charctersRelay) { ($0, $1) }
      .bind(to: pageLoader.dataPage)
      .disposed(by: disposeBag)

    pageLoader.pageNumber
      .map { [weak self] page in
        self?.loadCharactersAction.execute(page)
      }
      .drive()
      .disposed(by: disposeBag)

  }

  private func bindAction() {
    loadCharactersAction.elements
      .withLatestFrom(charctersRelay) { ($0, $1) }
      .map { [weak self] elements, list -> [Character] in
        guard let self = self else { return [] }
        return self.configureList(element: elements, list: list)
      }
      .bind(to: charctersRelay)
      .disposed(by: disposeBag)

    loadCharactersAction.executing
      .bind(to: isLoaderShownRelay)
      .disposed(by: disposeBag)

    loadCharactersAction.underlyingError
      .bind(to: errorsRelay)
      .disposed(by: disposeBag)
  }

  private func buildListCellViewModel(characterList: [Character]) -> [CharacterCellViewModel] {
    characterList.map {
      CharacterCellViewModel(id: $0.id,
                             image: $0.image,
                             name: $0.name,
                             species: $0.species,
                             gender: $0.gender)
    }
  }

  private func obtainSelectedCharacter(cellViewModel: CharacterCellViewModel) {
    cellViewModel.output.id
      .asObservable()
      .withLatestFrom(charctersRelay) { ($0, $1) }
      .flatMapLatest({ [weak self] characterId, characterList -> Single<Void> in
        guard let self = self,
              let character = characterList.first(where: { $0.id == characterId }) else { return .just(()) }
        return self.coordinator.openCharacterDetailsScreen(character: character)
      })
      .subscribe()
      .disposed(by: disposeBag)
  }

  private func configureList(element: CharacterListResponse, list: [Character]) -> [Character] {
    var innerList = list
    innerList.append(contentsOf: element.results)
    pageLoader.pageCount.accept(element.info.pages)
    return innerList
  }

}
