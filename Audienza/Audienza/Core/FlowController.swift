//
//  FlowController.swift
//  NetStreamAppleTV
//
//  Created by Oleksii Shvachenko on 5/21/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import UIKit
import AudienzaCore
import ReSwift

final class FlowController: ReSwift.StoreSubscriber {
  
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
    mainStore.subscribe(self) { subcription in
      subcription
        .select { state in state.flowState }
        .skipRepeats(==)
    }
  }

  func newState(state: NavigationFlow.State) {
    switch state {
    case .login:
      navigateToLogin()
    case .main:
      navigateToMain()
    }
  }
  
  private func navigateToLogin() {
     window.set(rootViewController: AppStoryboard.authentication.initialViewController)
  }
  
  private func navigateToMain() {
    // window.set(rootViewController: AppStoryboard.main.initialViewController)
  }
  
}
