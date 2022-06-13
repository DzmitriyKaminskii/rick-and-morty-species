//
//  PageLoader.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/23/22.
//

import UIKit

import RxSwift
import RxCocoa

class PageLoader {
  typealias PageData = (rows: [IndexPath], list: [Any])

  private var disposeBag: DisposeBag = DisposeBag()
  private let pageSize = 20

  let dataPage = BehaviorRelay<PageData>(value: ([], []))
  let pageCount = BehaviorRelay<Int>(value: 0)

  let pageNumber: Driver<Int>
  private let pageNumberRelay = BehaviorRelay<Int>(value: 1)

  init() {
    pageNumber = pageNumberRelay.asDriver()
    bind()
  }

  deinit {
    disposeBag = DisposeBag()
  }

  private func bind() {
    dataPage
      .map({ [weak self] rows, list in
        guard !rows.isEmpty && !list.isEmpty else { return }
        self?.obtainNewPageIfNeed(indexes: rows.map { $0.row }, countElements: list.count)
      })
      .subscribe()
      .disposed(by: disposeBag)
  }

  private func obtainNewPageIfNeed(indexes: [Int], countElements: Int) {
    guard
      let maxIndex = indexes.max(),
      countElements - maxIndex < 5
    else { return }

    let newPageNumber = pageNumberRelay.value + 1
    let isNeedNewPage = (pageSize * pageNumberRelay.value) == countElements

    if newPageNumber <= pageCount.value && isNeedNewPage {
      pageNumberRelay.accept(pageNumberRelay.value + 1)
    }
  }

}
