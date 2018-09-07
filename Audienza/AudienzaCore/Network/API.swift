//
//  API.swift
//  NetStreamCore
//
//  Created by YevhenHerasymenko on 8/13/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Foundation

/// API info
public struct API {
  private let server: String

  /// host information
  public var host: String {
    guard let urlComponents = URLComponents(string: server),
      let host = urlComponents.host else {
        fatalError("Incorrect environment url: \(server)")
    }
    return host
  }

  var url: String {
    return server / "ib"
  }

  init(server: String) {
    self.server = server
  }
}
