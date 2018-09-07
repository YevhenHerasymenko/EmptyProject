//
//  FontManager.swift
//  Stratege
//
//  Created by Yevhen Herasymenko on 10/01/2016.
//  Copyright © 2016 Stratege. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
  
  enum OpenSans: String {
    case regular = "OpenSans"
    case semibold = "OpenSans-Semibold"
  }
  
  private static func loadFont(name: String, size: CGFloat) -> UIFont {
    guard let font = UIFont(name: name, size: size) else {
      fatalError("can't load font named \(name)")
    }
    return font
  }
  
  private static func openSansRegular(size: CGFloat) -> UIFont {
    return loadFont(name: OpenSans.regular.rawValue, size: size)
  }
  
  private static func openSansSemibold(size: CGFloat) -> UIFont {
    return loadFont(name: OpenSans.semibold.rawValue, size: size)
  }
  
  static var title2 = openSansRegular(size: 56)
  static var title3 = openSansRegular(size: 48)
  static var headline = openSansRegular(size: 40)
  static var callout = openSansRegular(size: 32)
  static var body = openSansRegular(size: 32)
  static var bodyBold = openSansRegular(size: 32)
  static var subhead = openSansRegular(size: 32)
  static var caption1 = openSansRegular(size: 24)
  static var caption3 =  openSansRegular(size: 24)
  static var info = openSansRegular(size: 16)
}
