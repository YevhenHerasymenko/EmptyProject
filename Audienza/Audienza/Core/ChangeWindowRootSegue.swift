//
//  AuthorizedSegue.swift
//  ukmdm
//
//  Created by Yevhen Herasymenko on 12/9/17.
//  Copyright © 2017 UK MDM. All rights reserved.
//

import UIKit

extension UIWindow {

  /**
   Additional method to UIWindow for changing root view controller. This method is creating for removing views that can
   still be im memory after root changing by default way.

   - parameter newRootViewController: new root view controller for window
   - parameter transition: used for any additional animation during root changing
 */
  func set(rootViewController newRootViewController: UIViewController,
           withTransition transition: CATransition? = nil) {
    let previousViewController = rootViewController
    if let transition = transition {
      layer.add(transition, forKey: kCATransition)
    }

    rootViewController = newRootViewController
    if let transitionViewClass = NSClassFromString("UITransitionView") {
      for subview in subviews where subview.isKind(of: transitionViewClass) {
        subview.removeFromSuperview()
      }
    }
    if let previousViewController = previousViewController {
      previousViewController.dismiss(animated: false) {
        previousViewController.view.removeFromSuperview()
      }
    }
  }
  
}

/**
 Segue for changing root view controller for window withoud any additional actions.
 Class created for ability to use it in interface builder and keep visual structure for app.
 */
final class ChangeWindowRootSegue: UIStoryboardSegue {

  override func perform() {
    guard let window = source.view.window else { return }
    let transition: CATransition?
    if UIView.areAnimationsEnabled {
      transition = CATransition()
      transition?.type = kCATransitionFade
    } else {
      transition = nil
    }
    window.set(rootViewController: destination, withTransition: transition)
  }

}
