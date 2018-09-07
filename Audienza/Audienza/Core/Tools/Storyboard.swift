//
//  Storyboard.swift
//  Profile
//
//  Created by YevhenHerasymenko on 1/23/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import UIKit

enum AppStoryboard: String {
  
  case authentication = "Authentication"
  
  var instance: UIStoryboard {
    return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
  }
  
  var initialViewController: UIViewController {
    guard let controller = instance.instantiateInitialViewController() else {
      fatalError("No initial view controller for \(rawValue)")
    }
    return controller
  }
  
  func viewController<T: UIViewController>(_ viewControllerClass: T.Type) -> T? {
    let storyboardId = (viewControllerClass as UIViewController.Type).storyboardId
    return instance.instantiateViewController(withIdentifier: storyboardId) as? T
  }
  
}

extension UIViewController {
  
  @nonobjc class var storyboardId: String {
    return "\(self)"
  }
  
  static func instantiate(from storyboard: AppStoryboard) -> Self {
    guard let controller = storyboard.viewController(self) else {
      fatalError("Cannot instantiate \(self) from \(storyboard.rawValue)")
    }
    return controller
  }
  
}
