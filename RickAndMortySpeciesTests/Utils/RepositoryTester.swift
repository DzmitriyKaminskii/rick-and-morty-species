// swiftlint:disable implicitly_unwrapped_optional
// swiftlint:disable force_unwrapping
//
//  RepositoryTester.swift
//  RickAndMortySpecies Tests
//
//  Created by Dzmitry Kaminski on 5/22/22.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest

class RepositoryTester {
  private var scheduler: TestScheduler!
  private var disposeBag: DisposeBag = DisposeBag()

  init() {
    scheduler = TestScheduler(initialClock: 0)
  }

  func testSuccessfulResponse<Response: Equatable, Repository>(ofType responseType: Response.Type,
                                                               fromRepository repository: Repository,
                                                               expectedResponse: Response,
                                                               processing: (Repository) -> Observable<Response>) {
    let resultObserver = scheduler.createObserver(responseType)

    processing(repository)
      .bind(to: resultObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(resultObserver.events.first!, .next(0, expectedResponse))
  }

  func testFailedResponse<Response: Equatable, Repository>(ofType responseType: Response.Type,
                                                           fromRepository repository: Repository,
                                                           expectedError: Error,
                                                           processing: (Repository) -> Observable<Response>) {
    let resultObserver = scheduler.createObserver(responseType)

    processing(repository)
      .bind(to: resultObserver)
      .disposed(by: disposeBag)

    XCTAssertEqual(resultObserver.events.first!, .error(0, expectedError))
  }
}
