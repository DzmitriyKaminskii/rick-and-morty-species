//
//  ErrorShowing.swift
//  RickAndMortySpecies
//
//  Created by Dzmitry Kaminski on 5/21/22.
//

import MaterialComponents.MaterialSnackbar

public protocol ErrorShowing {}

public extension ErrorShowing {

  func showError(message: String) {
    let message = MDCSnackbarMessage(text: message)
    let manager = MDCSnackbarManager()
    manager.snackbarMessageViewBackgroundColor = Colors.loaderBackground.color
    manager.snackbarMessageViewShadowColor = Colors.shadow.color
    manager.messageTextColor = .white
    manager.show(message)
  }

}
