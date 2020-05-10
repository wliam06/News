//
//  MockServiceSession.swift
//  NewsTests
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
class MockServiceSession: ServiceSession {
  var invokedLoad = false
  var invokedLoadCount = 0
  var invokedLoadParameters: (url: URLRequest, Void)?
  var invokedLoadParametersList = [(url: URLRequest, Void)]()
  var stubbedLoadCompletionResult: (Data?, URLResponse?, Error?)?
  func load(url: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void) {
    invokedLoad = true
    invokedLoadCount += 1
    invokedLoadParameters = (url, ())
    invokedLoadParametersList.append((url, ()))
    if let result = stubbedLoadCompletionResult {
      completion(result.0, result.1, result.2)
    }
  }
}

/**
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
 
 */
