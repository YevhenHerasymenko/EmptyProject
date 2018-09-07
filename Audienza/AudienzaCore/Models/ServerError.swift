//
//  ServerError.swift
//  NetStreamCore
//
//  Created by Oleksii Shvachenko on 5/7/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import ObjectMapper

/// Model for showing server error
public struct ServerError: ImmutableMappable {
  /// error message
  public let message: String?
  /// error code
  public let code: String

  /// required init
  public init(map: Map) throws {
    message = try? map.value("errorMessage")
    code = try map.value("errorCode")
  }
}
