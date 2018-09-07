//
//  AppDelegate.swift
//  Audienza
//
//  Created by YevhenHerasymenko on 9/4/18.
//  Copyright © 2018 Bumagi. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import AlamofireNetworkActivityIndicator
import AudienzaCore
import ReSwift

var mainStore: Store<AppState>! {
  return (UIApplication.shared.delegate as? AppDelegate)?.store
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private(set) var store: Store<AppState>!
  private var sessionManager: NetworkSessionManager!
  var flowController: FlowController?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    Fabric.with([Crashlytics.self])
    
    setupCore()
    mainStore.dispatch(AppState.Actions.clearData)
    
    setupActivityIndicator()
    setupFlow()
    
    return true
  }
  
  private func setupFlow() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = UIViewController()
    flowController = FlowController(window: window)
    window.makeKeyAndVisible()
    self.window = window
  }
  
  private func setupCore() {
    let host = Configuration.current.environment.api.host
    sessionManager = SessionManager(host: host)
    store = createStore(sessionManager)
  }
  
  private func setupActivityIndicator() {
    NetworkActivityIndicatorManager.shared.isEnabled = true
    NetworkActivityIndicatorManager.shared.completionDelay = 0.2
    NetworkActivityIndicatorManager.shared.startDelay = 0.1
  }
  
}
