//
//  NetworkError.swift
//
//  Created by YevhenHerasymenko.
//  Copyright © 2017 Yevhen Herasymenko. All rights reserved.
//

import ObjectMapper

/// Server error codes
public enum ErrorCode: String {
  /// wrong credentials
  case authenticationFailed = "AUTHENTICATION_FAILED"
}

/// List of network errors
public enum NetworkError: Error {
  /// no internet
  case noInternetConnection
  /// timeout (time can be different for different requests)
  case timeout
  /// unexpected response
  case badResponse
  /// error during generation app model from server response (JSON)
  case parsingError
  /// particular error from server side
  case server(ServerError)
  /// the others cases
  case unknown
}
