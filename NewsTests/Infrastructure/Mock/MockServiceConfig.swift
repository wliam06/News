//
//  MockServiceConfig.swift
//  NewsTests
//
//  Created by William on 28/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
class MockServiceConfig: BaseServiceConfig {
  var baseURL: URL = URL(string: "https://test.com")!
  var headers: [String : String] = [:]
  var parameters: [String : String] = [:]
}
