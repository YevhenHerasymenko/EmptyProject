//
//  SessionManager.swift
//  NetStreamAppleTV
//
//  Created by YevhenHerasymenko on 4/30/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Alamofire
import ObjectMapper

/**
 Protocol for routers. Protocol expands URLRequestConvertible which Alamofire uses for requsts with MockableRequest
 which allows profide mock files for testing
 */
public protocol NetworkRouting: URLRequestConvertible {}

/**
 Protocol for request which describe how each request should be prapared with specific credentials.
 */
public protocol RequestAdapter {}

/**
 Protocol for request which describe how each request should be retried.
 */
public protocol RequestRetrier {}

/**
 Protocol describes basic functions for Session managers it provides opportunity to create specific session manager 
 for unit testing or etc
 */
public protocol NetworkSessionManager {

  /// method for setting request adapter
  func setRequest(adapter: RequestAdapter)

  /// method for setting request retrier
  func setRequest(retrier: RequestRetrier)

  /// method for request with simple object in response
  func perform<T: ImmutableMappable>(request value: NetworkRouting,
                                     resultCallback: @escaping (NetworkResult<T>) -> Void)

  /// method for request with array of objects in response
  func perform<T: ImmutableMappable>(request value: NetworkRouting,
                                     resultCallback: @escaping (NetworkResult<[T]>) -> Void)
}

extension NetworkSessionManager {
  
  func setRequest(adapter: RequestAdapter) {}

  func setRequest(retrier: RequestRetrier) {}

}

/// Network Result. Generic Enum for server response
public enum NetworkResult<T> {

  /// with generic type
  case success(T)

  /// case for errors in response
  case failure(NetworkError)
}
