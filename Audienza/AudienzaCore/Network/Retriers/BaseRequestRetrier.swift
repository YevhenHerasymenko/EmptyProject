//
//  BaseRequestRetrier.swift
//  NetStreamAppleTV
//
//  Created by Oleksii Shvachenko on 5/17/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Alamofire

class BaseRequestRetrier: RequestRetrier, Alamofire.RequestRetrier {
  
  func should(_ manager: Alamofire.SessionManager,
              retry request: Alamofire.Request,
              with error: Error,
              completion: @escaping Alamofire.RequestRetryCompletion) {
    guard request.retryCount < Configuration.current.environment.retryCount else {
      completion(false, 0)
      return
    }
    if error is NetworkError {
      completion(false, 0)
      return
    }
    completion(true, 0)
  }
  
}
