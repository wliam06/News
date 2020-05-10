//
//  ServiceManagerTests.swift
//  NewsTests
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
class ServiceManagerTests: XCTestCase {
  var mockSession: MockServiceSession?
  var manager: ServiceManager?

  override func setUp() {
    mockSession = MockServiceSession()
    manager = ServiceManager(session: mockSession!)
  }

  override func tearDown() {
    mockSession = nil
  }

  func testInvalidLoadService() {
    let expectError = ErrorRespond(type: .network)
    mockSession?.stubbedLoadCompletionResult = (nil, nil, expectError)
    
    let url: URL = URL(string: Constant.baseURL + "/top-headlines")!
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = ServiceManager.header

    manager?.load(.topHeadlines, completion: { (data, error) in
      XCTAssert(data == nil, "Expect data is empty")
      XCTAssert(error == expectError, "Expect error is exist")
    })

    XCTAssert(mockSession?.invokedLoad == true, "Expect session is loaded")
    XCTAssert(mockSession?.invokedLoadCount == 1, "Expect session is loaded once")
    XCTAssert(mockSession?.invokedLoadParameters?.url == urlRequest, "Expect load param is same with url request")
  }

  func testPerformanceExample() {
    self.measure {
        // Put the code you want to measure the time of here.
    }
  }
}
