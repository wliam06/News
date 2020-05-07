//
//  MockServiceManager.swift
//  NewsTests
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
class MockServiceManager: ServiceManager {
  var path: ServicePath?
  var params: [String: Any]?
  private(set) var count = 0

  override func load(_ path: ServicePath,
                     params: [String : Any]? = nil,
                     completion: @escaping (Data?, ErrorRespond?) -> Void) {
    self.path = path
    self.params = params

    count += 1

    super.load(path, params: params, completion: completion)
  }
}
