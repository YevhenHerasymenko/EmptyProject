//
//  AppState.swift
//
//  Created by Oleksii Shvachenko.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import ReSwift

public struct AppState: StateType {
  /// State for indicating current application flow
  public var flowState: NavigationFlow.State
  /// State for keeping error information
  public let errorState: ErrorFlow.State
  
  public enum Actions: ReSwift.Action {
    /// action for clear whole data in app state
    case clearData
  }
}

extension AppState {
  static func appReducer(action: Action, state: AppState?) -> AppState {
    switch action {
    case AppState.Actions.clearData:
      return AppState(
        flowState: .login,
        errorState: ErrorFlow.State()
      )
    default:
      return AppState(
        flowState: state?.flowState ?? .login,
        errorState: ErrorFlow.Reducer.handleAction(action: action, state: state?.errorState)
      )
    }
  }
}

public func createStore(_ sessionManager: NetworkSessionManager) -> Store<AppState> {
  return Store<AppState>(
    reducer: AppState.appReducer,
    state: nil,
    middleware: [createMiddleware(load(service: sessionManager))]
  )
}

extension AppState {
  
  /// clear all state data
  public static func clearData() -> ReSwift.Store<AppState>.ActionCreator {
    return { state, store in
      return Actions.clearData
    }
  }
  
  /// check storet data and perform initial navigation
  public static func setupInitialFlow() -> ReSwift.Store<AppState>.ActionCreator {
    return { state, store in
      return Actions.clearData
    }
  }
  
}
