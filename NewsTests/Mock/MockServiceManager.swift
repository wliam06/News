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
  var invokedLoad = false
  var invokedLoadCount = 0
  var invokedLoadParameters: (path: ServicePath, params: [String: Any]?)?
  var invokedLoadParametersList = [(path: ServicePath, params: [String: Any]?)]()
  var stubbedLoadCompletionResult: (Data?, ErrorRespond?)?
  override func load(_ path: ServicePath, params: [String: Any]? = nil, completion: @escaping(Data?, ErrorRespond?) -> Void) {
    invokedLoad = true
    invokedLoadCount += 1
    invokedLoadParameters = (path, params)
    invokedLoadParametersList.append((path, params))
    super.load(path, params: params, completion: completion)
  }
}
