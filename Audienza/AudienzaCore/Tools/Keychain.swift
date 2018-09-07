//
//  Keychain.swift
//  Bumagi
//
//  Created by Yevhen Herasymenko on 10/22/16.
//  Copyright © 2016 Yevhen Herasymenko. All rights reserved.
//

import Foundation
import KeychainSwift

struct KeychainService {

  /**
   Enum for keychain keys. Working with enum saves from typo.
 */
  enum Keys: String {
    case authenticateToken
    case pairingToken
  }
  
  private static let semaphore = DispatchSemaphore(value: 1)
  private static let keychain: KeychainSwift = KeychainSwift(keyPrefix: "NetStream")

  /**
   Save string into keychain by specific key.

   - parameter value: string for saving
   - parameter key: key for keychain
 */
  static func saveString(_ value: String, forKey key: Keys) {
    semaphore.wait()
    keychain.set(value, forKey: key.rawValue, withAccess: .accessibleWhenUnlocked)
    semaphore.signal()
  }

  /**
   Getting value from keychain

   - parameter key: key for keychain

   - returns: Value from keychain
 */
  static func getStringForKey(_ key: Keys) -> String? {
    semaphore.wait()
    defer {
      semaphore.signal()
    }
    return keychain.get(key.rawValue)
  }

  /**
   Remove value from keychain

   - parameter key: key from keychain
 */
  static func removeValueForKey(_ key: Keys) {
    semaphore.wait()
    keychain.delete(key.rawValue)
    semaphore.signal()
  }

  /**
   Remove all keys from keychain
 */
  static func clear() {
    semaphore.wait()
    keychain.clear()
    semaphore.signal()
  }
  
}
