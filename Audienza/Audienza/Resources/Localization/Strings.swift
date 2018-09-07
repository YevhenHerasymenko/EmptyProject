//
//  Strings.swift
//  ShakeMe Up
//
//  Created by Yevhen Herasymenko on 11/21/16.
//  Copyright © 2016 Yevhen Herasymenko. All rights reserved.
//

import Foundation

extension String {

  static func localize(_ value: Localizable) -> String {
    return NSLocalizedString(value.rawValue, comment: "")
  }

  static func localizedString(_ string: String?) -> String? {
    guard let string = string else {
      return nil
    }
    return NSLocalizedString(string, comment: "")
  }
  
}
