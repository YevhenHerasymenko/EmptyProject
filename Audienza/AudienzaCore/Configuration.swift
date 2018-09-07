//
//  Environment.swift
//  NetStreamCore
//
//  Created by Oleksii Shvachenko on 6/4/18.
//  Copyright © 2018 Ciklum. All rights reserved.
//

import Foundation
import ObjectMapper

/// Class for providung information about all values which are configurable
public class Configuration: ImmutableMappable {
  
  /// Struct contains environmant information
  public struct Environment: ImmutableMappable {
    /// api host url
    public let api: API
    
    let retryCount: Int
    
    /// required init
    public init(map: Map) throws {
      retryCount = try map.value("configuration.retry count")
      let url: String = try map.value("url")
      api = API(server: url)
    }
  }
  
  /// current configuration as singleton
  public static let current: Configuration = loadSelectedConfiguration()
  
  /// environmants constants
  public let environment: Environment
  
  public required init(map: Map) throws {
    environment = try map.value("Environment")
  }
  
  private static func loadSelectedConfiguration() -> Configuration {
    guard
      let configurationPath = Bundle(for: Configuration.self).path(forResource: "Configuration", ofType: "plist"),
      let configurationDict = NSDictionary(contentsOfFile: configurationPath) else {
        fatalError("Bundle must contain Environments.plist file")
    }
    let configuration = (Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String) ?? "Default"
    guard let currentConfiguration = configurationDict.object(forKey: configuration) as? [String: Any] else {
      fatalError("can't find configuration: \(configuration)")
    }
    guard let instance = try? Configuration(JSON: currentConfiguration) else {
      fatalError("can't setup configuration")
    }
    return instance
  }
  
}
