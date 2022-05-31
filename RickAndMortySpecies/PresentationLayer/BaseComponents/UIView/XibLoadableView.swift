//
//  XibLoadableView.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import UIKit

class XibLoadableView: BindableView {

  // swiftlint:disable:next implicitly_unwrapped_optional
  private(set) var embeddedView: UIView!

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.embeddedView = embedNib()
    style()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.embeddedView = embedNib()
    style()
  }

}

private extension UIView {

  func embedNib(nibNameOrNil: String? = nil) -> UIView {
    let view = loadFromNib(nibNameOrNil: nibNameOrNil)
    addSubview(view)
    stretch(view: view)
    return view
  }

  func loadFromNib<T: UIView>(nibNameOrNil: String? = nil) -> T {
    let selfType = type(of: self)
    let bundle = Bundle(for: selfType)
    var nibName = String(describing: selfType)
    if let nibNameOrNil = nibNameOrNil {
      nibName = nibNameOrNil
    }
    let nib = UINib(nibName: nibName, bundle: bundle)
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
      fatalError("Error loading nib with name \(nibName)")
    }

    return view
  }

  func stretch(view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: topAnchor),
      view.leftAnchor.constraint(equalTo: leftAnchor),
      view.rightAnchor.constraint(equalTo: rightAnchor),
      view.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

}
