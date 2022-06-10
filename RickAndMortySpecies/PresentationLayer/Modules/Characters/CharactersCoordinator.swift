//
//  CharactersCoordinator.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/19/22.
//

import RxCocoa
import RxSwift

class CharactersCoordinator: BaseCoordinator<Void> {

  private enum Constants {

    static let deepLinkParamName = "id"

  }

  private weak var rootViewController: UINavigationController?

  init(rootViewController: UINavigationController) {
    self.rootViewController = rootViewController

    super.init()
  }

  override func start() {
    super.start()

    showCharacterListScreen()
  }

  override func canHandleLink(linkType: LinkType) -> Bool {
    linkType == .characterDetails
  }

  override func handleLink(_ linkData: LinkData) {
    guard let characterParam = linkData.queryParams?[Constants.deepLinkParamName],
          let characterId = Int(characterParam),
    linkData.type == .characterDetails else { return }

    let detailsCoordinator = CharacterDetailsCoordinator(rootViewController: rootViewController,
                                                         characterId: characterId)

    if let child = childCoordinators.last {
      remove(child: child)
    }

    navigate(to: detailsCoordinator)
      .subscribe()
      .disposed(by: disposeBag)
  }

  private func showCharacterListScreen() {
    guard let viewController = ApplicationAssembly
      .resolver
      .resolve(CharacterListTableViewController.self, coordinator: self)
    else {
      fatalError("Expected dependency \(CharacterListTableViewController.self)")
    }

    rootViewController?.setViewControllers([viewController], animated: false)
  }

}

extension CharactersCoordinator: CharactersCoordinatorInput {

  func openCharacterDetailsScreen(character: Character) -> Single<Void> {
    let characterDetailsCoordinator = CharacterDetailsCoordinator(rootViewController: rootViewController,
                                                                  character: character)

    return navigate(to: characterDetailsCoordinator)
  }

}
