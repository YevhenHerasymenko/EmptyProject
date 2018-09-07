//
//  LoginRequestAdapter.swift
//  NetStreamCore
//
//  Created by YevhenHerasymenko on 5/21/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Alamofire

class LoginRequestAdapter: RequestAdapter, Alamofire.RequestAdapter {

  private struct Values {
    static let basicAuthorization = "Basic"
    static let tenantId = "tenantId"
    static let authorization = "Authorization"
  }

  let authorization: String
  let tenantId: String

  init(email: String, password: String, tenantId: String) {
    guard let authData = "\(email):\(password)".data(using: .utf8) else {
      fatalError("wrong encoding")
    }
    self.authorization = authData.base64EncodedString()
    self.tenantId = tenantId
  }

  func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
    var request = urlRequest
    request.addValue(tenantId, forHTTPHeaderField: Values.tenantId)
    request.addValue(Values.basicAuthorization.appending(" \(authorization)"),
                     forHTTPHeaderField: Values.authorization)
    return request
  }

}
