//
//  UserDefaultService.swift
//  Profile
//
//  Created by YevhenHerasymenko on 1/27/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import Foundation

struct UserDefaultsService {

  /**
   Enum for keychain keys. Working with enum saves from typo.
   */
  enum Keys: String {
    case server
  }

  /**
   Save string into user defaults by specific key.

   - parameter value: string for saving
   - parameter key: key for user defaults
   */
  static func save(_ value: Any, forKey key: UserDefaultsService.Keys) {
    UserDefaults.standard.set(value, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }

  static func register(_ value: Any, forKey key: UserDefaultsService.Keys) {
    UserDefaults.standard.register(defaults: [key.rawValue: value])
    UserDefaults.standard.synchronize()
  }

  /**
   Getting value from user defaults

   - parameter key: key for user defaults

   - returns: Value from user defaults
   */
  static func value(for key: UserDefaultsService.Keys) -> Any? {
    return UserDefaults.standard.value(forKey: key.rawValue)
  }

  static func removeValue(for key: UserDefaultsService.Keys) {
    UserDefaults.standard.removeObject(forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }

}
