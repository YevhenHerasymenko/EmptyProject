//
//  SessionManager.swift
//  NetStreamAppleTV
//
//  Created by Oleksii Shvachenko on 5/3/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Alamofire
import ObjectMapper
import AudienzaCore

class SessionManager: NetworkSessionManager {

  private let parseOperationQueue = OperationQueue()
  private let passResultOperationQueue = OperationQueue()
  private var session: Alamofire.SessionManager

  init(host: String) {
    passResultOperationQueue.underlyingQueue = DispatchQueue.main
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 20
    let serverTrustPolicies = ServerTrustPolicyManager(policies: [host: .disableEvaluation])
    session = Alamofire.SessionManager(
      configuration: configuration,
      serverTrustPolicyManager: serverTrustPolicies)
  }

  func setRequest(adapter: AudienzaCore.RequestAdapter) {
    if let adapter = adapter as? Alamofire.RequestAdapter {
      session.adapter = adapter
    }
  }

  func setRequest(retrier: AudienzaCore.RequestRetrier) {
    if let retrier = retrier as? Alamofire.RequestRetrier {
      session.retrier = retrier
    }
  }

  func perform<T: ImmutableMappable>(request value: NetworkRouting,
                                     resultCallback: @escaping (NetworkResult<T>) -> Void) {
    session
      .request(value)
      .validate(statusCode: 200..<300)
      .responseJSON { response in
        switch response.result {
        case .success(let result):
          var result = result
          if result is NSNull {
            result = [:]
          }
          guard let resultDictionary = result as? [String: AnyObject] else {
            resultCallback(NetworkResult<T>.failure(.badResponse))
            return
          }
          do {
            let object = try Mapper<T>().map(JSON: resultDictionary)
            resultCallback(NetworkResult<T>.success(object))
          } catch {
            resultCallback(NetworkResult<T>.failure(.parsingError))
          }
        case .failure(let error):
          resultCallback(NetworkResult<T>.failure(SessionManager.parse(error: error, with: response)))
        }
    }
  }
  
  func perform<T: ImmutableMappable>(request value: NetworkRouting,
                                     resultCallback: @escaping (NetworkResult<[T]>) -> Void) {
    session
      .request(value)
      .validate(statusCode: 200..<300)
      .responseJSON { [weak self] response in
        switch response.result {
        case .success(let result):
          guard let resultDictionary = result as? [[String: AnyObject]] else {
            resultCallback(NetworkResult<[T]>.failure(.badResponse))
            return
          }
          let parseOperation = AsyncBlockOperation<NetworkResult<[T]>> { (operation) in
            do {
              let objects = try Mapper<T>().mapArray(JSONArray: resultDictionary)
              operation.result = NetworkResult<[T]>.success(objects)
            } catch {
              operation.result = NetworkResult<[T]>.failure(.parsingError)
            }
            operation.complete()
          }
          let passResultOperation = BlockOperation {
            guard let result = parseOperation.result else {
              fatalError()
            }
            resultCallback(result)
          }
          passResultOperation.addDependency(parseOperation)
          self?.passResultOperationQueue.addOperation(passResultOperation)
          self?.parseOperationQueue.addOperation(parseOperation)
        case .failure(let error):
          resultCallback(NetworkResult<[T]>.failure(SessionManager.parse(error: error, with: response)))
        }
    }
  }
  
  private static func parse(error: Error, with response: DataResponse<Any>) -> NetworkError {
    guard let responseData = response.data, !responseData.isEmpty else {
      return error.asNetworkError()
    }
    guard let json = try? JSONSerialization.jsonObject(with: responseData, options: []),
      let errorDict = json as? [String: AnyObject] else {
        return .badResponse
    }
    
    guard let error = try? Mapper<ServerError>().map(JSON: errorDict) else {
      return .parsingError
    }
    
    return .server(error)
  }
  
}
