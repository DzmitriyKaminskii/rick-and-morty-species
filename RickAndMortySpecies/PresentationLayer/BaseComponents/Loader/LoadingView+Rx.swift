//  swiftlint:disable:this file_name
//  LoadingView+Rx.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import UIKit

import RxCocoa
import RxSwift

public extension Reactive where Base: LoadingView {

  static func isActivityIndicatorShown(inViewController viewController: UIViewController) -> Binder<Bool> {
    isActivityIndicatorShown(inView: viewController.view)
  }

  static func isActivityIndicatorShown(inView view: UIView,
                                       animated: Bool = true,
                                       configuring: ((LoadingView) -> Void)? = nil) -> Binder<Bool> {
    Binder(UIApplication.shared) { [weak view] _, isVisible in
      guard let view = view else { return }
      showHideLoading(view: view, isVisible: isVisible, animated: animated, configuring: configuring)
    }
  }

  private static func showHideLoading(view: UIView,
                                      isVisible: Bool,
                                      animated: Bool = true,
                                      configuring: ((LoadingView) -> Void)? = nil) {
    if isVisible {
      LoadingView.showActivityIndicator(inView: view, animated: animated, configuring: configuring)
    } else {
      LoadingView.dismissActivityIndicator(fromView: view, animated: animated)
    }
  }

}
