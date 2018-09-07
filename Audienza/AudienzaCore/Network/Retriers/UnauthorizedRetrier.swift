//
//  UnauthorizedRetrier.swift
//  NetStreamCore
//
//  Created by Oleksii Shvachenko on 31/05/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Alamofire

class UnauthorizedRetrier: BaseRequestRetrier {

  override func should(_ manager: Alamofire.SessionManager,
                       retry request: Alamofire.Request,
                       with error: Error,
                       completion: @escaping Alamofire.RequestRetryCompletion) {
    if let response = request.response, response.statusCode == Constants.NetworkStatusCode.unauthorized {
      // do something
    } else {
      super.should(manager, retry: request, with: error, completion: completion)
    }
  }

}
