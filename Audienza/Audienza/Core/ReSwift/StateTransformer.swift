//
//  Lens.swift
//  ReSwiftSample_Stratege
//
//  Created by YevhenHerasymenko on 6/2/17.
//  Copyright © 2017 Ciklum. All rights reserved.
//

import AudienzaCore

/// Protocol for explanation how to create view controller state from app state
public protocol StateTransformer {
  /// The type of ViewControllers Model
  associatedtype ViewState
 
  /// Main function for transformation AppState to ViewState
  static func transform(_ state: AppState) -> ViewState
  /// Function for filtering same ViewStates
  static func filter(old: ViewState, new: ViewState) -> Bool
}

public extension StateTransformer {
  
  /// Default realization for filter
  public static func filter(old: ViewState, new: ViewState) -> Bool {
    return true
  }
  
}
