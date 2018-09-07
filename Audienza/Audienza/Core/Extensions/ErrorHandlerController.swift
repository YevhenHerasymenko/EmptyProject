//
//  ErrorHandlerController.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/2/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit

struct ErrorModel: Equatable {
  
  let title: String?
  let message: String?
  let type: ErrorType
  
  static func == (lhs: ErrorModel, rhs: ErrorModel) -> Bool {
    return
        lhs.title == rhs.title &&
        lhs.message == rhs.message &&
        lhs.type == rhs.type
  }
  
}

enum ErrorType: Equatable {
  
  case alert
  case custom
  
  static func == (lhs: ErrorType, rhs: ErrorType) -> Bool {
    switch (lhs, rhs) {
    case (.alert, .alert), (.custom, .custom):
      return true
    default:
      return false
    }
  }
  
}

struct AlertAction {
  let title: String
  let style: UIAlertActionStyle
  let action: (() -> Void)?
}

/**
 ErrorHandlerController is specific protocol for view controller to show that current controller can show error alerts
 */
protocol ErrorHandlerController {
  func showError(model: ErrorModel, actions: [AlertAction], completion: (() -> Void)?)
}

extension ErrorHandlerController where Self: UIViewController {
  
  func showError(model: ErrorModel, actions: [AlertAction], completion: (() -> Void)?) {
    switch model.type {
    case .alert:
      showAlert(title: model.title, message: model.message, actions: actions, completion: completion)
    case .custom:
      showCutomAlert(title: model.title, message: model.message, actions: actions, completion: completion)
    }
  }
  
  private func showAlert(title: String?,
                         message: String?,
                         actions: [AlertAction],
                         completion: (() -> Void)?) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertActions = actions.compactMap { action -> UIAlertAction in
      return UIAlertAction(title: action.title, style: action.style, handler: { _ in
        action.action?()
      })
    }
    for action in alertActions {
      alertController.addAction(action)
    }
    if let controller = presentedViewController {
      controller.present(alertController, animated: true, completion: completion)
    } else {
      self.present(alertController, animated: true, completion: completion)
    }
  }
  
  private func showCutomAlert(title: String?,
                              message: String?,
                              actions: [AlertAction],
                              completion: (() -> Void)?) {

  }
  
}
