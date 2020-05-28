//
//  MockRequest.swift
//  NewsTests
//
//  Created by William on 28/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
struct MockRequest: Request {
  public var path: String
  public var isFullPath = false
  public var method: HTTPMethod
  public var header: [String: String] = [:]
  public var queryParametersEncodable: Encodable? = nil
  public var queryParameters: [String: Any] = [:]
  public var bodyParamatersEncodable: Encodable? = nil
  public var bodyParamaters: [String: Any] = [:]
  public var bodyEncoding: BodyEncoding = .encodingAscii

  init(path: String, method: HTTPMethod) {
    self.path = path
    self.method = method
  }
}
