//
//  LoadingView.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import Action
import UIKit
import SnapKit

public class LoadingView: UIView {

  public enum LoadingViewStyle {

    case standart
    case light
    case dark

  }

  public var style = LoadingViewStyle.standart {
    didSet {
      switch style {
      case .dark:
        self.overrideUserInterfaceStyle = .dark
      case .light:
        self.overrideUserInterfaceStyle = .light
      case .standart:
        self.overrideUserInterfaceStyle = .unspecified
      }
    }
  }

  private enum Constants {
    static let blurAlpha: CGFloat = 0.6
    static let animationDuration: TimeInterval = 0.3
  }

  private var indicatorView: UIView?

  public init() {
    super.init(frame: CGRect.zero)
    createView()
  }

  override public init(frame: CGRect) {
    super.init(frame: frame)
    createView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    createView()
  }

  private func createView() {
    self.backgroundColor = .clear

    addBlurView()
  }

  private func addBlurView() {
    let blurEffect = UIBlurEffect(style: .prominent)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.alpha = Constants.blurAlpha
    self.addSubview(blurView)

    blurView.snp.makeConstraints({ $0.size.equalTo(self) })
  }

  private func show(inView view: UIView, animated: Bool = true) {

    self.indicatorView?.removeFromSuperview()

    if indicatorView == nil {
      self.alpha = 0
    }

    view.addSubview(self)
    self.snp.makeConstraints({ $0.size.equalTo(view) })
    self.disableUserInteraction(inView: view)

    let factory = IndicatorSubviewFactory()
    indicatorView = factory.indicatorView()
    if let indicatorView = indicatorView {
      self.addSubview(indicatorView)

      indicatorView.snp.makeConstraints({
        $0.center.equalTo(self)
      })
    }

    let animations = {
      self.alpha = 1
    }

    let completion: (Bool) -> Void = { _ in
      self.disableUserInteraction(inView: view)
    }

    if animated {
      UIView.animate(withDuration: Constants.animationDuration, animations: animations, completion: completion)
    } else {
      animations()
      completion(true)
    }
  }

  public func dismiss(fromView view: UIView, animated: Bool = true) {

    let animations = {
      self.alpha = 0
    }

    let completion: (Bool) -> Void = { _ in
      self.enableUserInteraction(inView: view)
      self.removeFromSuperview()
    }

    if animated {
      UIView.animate(withDuration: Constants.animationDuration, animations: animations, completion: completion)
    } else {
      animations()
      completion(true)
    }
  }

}

public extension LoadingView {

  static func showActivityIndicator(inView view: UIView,
                                    animated: Bool = true,
                                    configuring: ((LoadingView) -> Void)? = nil) {

    let loadingView = configureLoadingView(inView: view, configuring: configuring)
    guard let loadingViewIndicator = loadingView else { return }
    loadingViewIndicator.show(inView: view, animated: animated)
  }

  static func dismissActivityIndicator(fromView view: UIView, animated: Bool = true) {
    dismissLoadingViews(inView: view, animated: animated)
  }

  private static func configureLoadingView(inView view: UIView,
                                           configuring: ((LoadingView) -> Void)? = nil) -> LoadingView? {

    var loadingView = getTopLoadingView(inView: view)

    if loadingView == nil {
      loadingView = LoadingView(frame: view.bounds)
      if let loadingView = loadingView {
        configuring?(loadingView)
      }
    }

    return loadingView
  }

  private static func dismissLoadingViews(inView view: UIView, animated: Bool = true) {
    let loadingViews = getLoadingViews(inView: view)

    for loadingView in loadingViews {
      loadingView.dismiss(fromView: view, animated: animated)
    }
  }

  private static func getTopLoadingView(inView view: UIView) -> LoadingView? {
    for subview in view.subviews {
      if let loadingView = subview as? LoadingView {
        return loadingView
      }
    }
    return nil
  }

  private static func getLoadingViews(inView view: UIView) -> [LoadingView] {
    var loadingViewArray: [LoadingView] = []
    for subview in view.subviews {
      if let loadingView = subview as? LoadingView {
        loadingViewArray.append(loadingView)
      }
    }
    return loadingViewArray
  }

  private func disableUserInteraction(inView view: UIView) {
    for subview in view.subviews where !(subview is LoadingView) {
      subview.isUserInteractionEnabled = false
    }
  }

  private func enableUserInteraction(inView view: UIView) {
    for subview in view.subviews where !(subview is LoadingView) {
      subview.isUserInteractionEnabled = true
    }
  }
}

class IndicatorSubviewFactory {
  private enum Constants {
    static let activityIndicatorCornerRadius: CGFloat = 10
    static let activityIndicatorSide: CGFloat = 40
    static let reloadImageInsets: CGFloat = 10
  }

  func indicatorView() -> UIView {
    let createdIndicator = createRotatingIndicator()

    guard let indicatorView = createdIndicator else { return UIView() }

    indicatorView.backgroundColor = Colors.loaderBackground.color
    indicatorView.layer.cornerRadius = Constants.activityIndicatorCornerRadius

    indicatorView.snp.makeConstraints({
      $0.size.equalTo(CGSize(width: Constants.activityIndicatorSide, height: Constants.activityIndicatorSide))
    })

    return indicatorView
  }

  private func createRotatingIndicator() -> UIView? {
    let activityIndicator = UIActivityIndicatorView()
    activityIndicator.style = .medium
    activityIndicator.color = .white
    activityIndicator.startAnimating()

    return activityIndicator
  }

  private func createReloadingIndicator() -> UIView? {
    let reloadView = UIButton()
    reloadView.setImage(Images.icReload.image, for: .normal)
    reloadView.tintColor = .white
    return reloadView
  }

}
