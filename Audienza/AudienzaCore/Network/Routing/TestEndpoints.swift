//
//  EpgEndpoints.swift
//  NetStreamCore
//
//  Created by Oleksii Shvachenko on 5/06/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Alamofire

// swiftlint:disable identifier_name

struct EpgFilter {
  let from: Date
  let to: Date
  let channels: [String]
  let full: Bool
}

enum TestEndpoints: NetworkRouting {
  case test

  var method: HTTPMethod {
    return .get
  }

  var path: String {
    let baseURL = Configuration.current.environment.api.url
    switch self {
    case .test:
      return baseURL
    }
  }

  func asURLRequest() throws -> URLRequest {
    let url = try path.asURL()
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
    
    switch self {
    case .test:
      request = try URLEncoding.default.encode(request, with: ["": ""])
    }

    return request
  }

}
