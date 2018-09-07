//
//  NetworkError.swift
//  NetStreamAppleTV
//
//  Created by Oleksii Shvachenko on 5/7/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import AudienzaCore

extension NetworkError {
  var modelValue: ErrorModel {
    switch self {
    case .server(let error):
      return MessageBuilder.message(for: error)
    case .noInternetConnection:
      return ErrorModel(title: "Error 1",
                        message: "Error 1",
                        type: .custom)
    default:
      return ErrorModel(title: "Error 4",
                        message: "Error 4",
                        type: .custom)
    }
  }
}

extension Error {
  
  func asNetworkError() -> NetworkError {
    switch (self as NSError).code {
    case NSURLErrorNotConnectedToInternet:
      return .noInternetConnection
    case NSURLErrorTimedOut:
      return .timeout
    default:
      return .unknown
    }
  }
  
}

final class MessageBuilder {
  
  static func message(for error: ServerError) -> ErrorModel {
    guard let code = ErrorCode(rawValue: error.code) else {
      return ErrorModel(title: "Error 2",
                        message: "Error 2",
                        type: .custom)
    }
    switch code {
    case .authenticationFailed:
      return ErrorModel(title: "Error 3",
                        message: "Error 3",
                        type: .alert)
    }
  }
  
}
