//
//  FlowState.swift
//  NetStreamCore
//
//  Created by Oleksii Shvachenko on 5/21/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import ReSwift

/// Controll current application flow
public enum NavigationFlow {
  /// Navigation state
  public enum State: ReSwift.StateType, Equatable {
    /// Login flow
    case login
    
    /// Main flow, user authorized
    case main
    
    /// Comparator
    public static func == (lhs: State, rhs: State) -> Bool {
      switch (lhs, rhs) {
      case (.login, .login),
           (.main, .main):
        return true
      default:
        return false
      }
    }
    
  }
  
  enum Reducer {}
}

extension NavigationFlow {
  enum Actions: ReSwift.Action {
    case setFlow(State)
  }
}

extension NavigationFlow.Reducer {
  
  static func handleAction(action: ReSwift.Action, state: NavigationFlow.State?) -> NavigationFlow.State {
    var state = state ?? NavigationFlow.State.login
    guard let action = action as? NavigationFlow.Actions else {
      return state
    }
    switch action {
    case let .setFlow(flow):
      state = flow
    }
    return state
  }
  
}
