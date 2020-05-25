//
//  ServiceConfig.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

public protocol BaseServiceConfig {
  var baseURL: URL { get }
  var headers: [String : String] { get }
  var parameters: [String : String] { get }
}

public struct ServiceConfig: BaseServiceConfig {
  public let baseURL: URL
  public var headers: [String : String]
  public var parameters: [String : String]

  public init(baseURL: URL,
              headers: [String: String] = [:],
              parameters: [String: String] = [:]) {
    self.baseURL = baseURL
    self.headers = headers
    self.parameters = parameters
  }
}
