//
//  ServiceManagerTests.swift
//  NewsTests
//
//  Created by William on 28/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
private enum MockErrorResponse: Error {
  case someError
}

class ServiceManagerTests: XCTestCase {
  func test_successLoad() {
    let config = MockServiceConfig()
    let expect = self.expectation(description: "Should return correct data")
    let expectedResponseData = "Response".data(using: .utf8)!
    
    let mockRequest = MockRequest(path: "https://test.com", method: .get)
    let mockService = MockServiceRequest(data: expectedResponseData, response: nil, error: nil)
    let serviceManager = ServiceManager(config: config, session: mockService)
    
    // when
    _ = serviceManager.request(endpoint: mockRequest, completion: { (result) in
      guard let response = try? result.get() else {
        XCTFail("Failed get data response")
        return
      }

      XCTAssertEqual(response, expectedResponseData)
      expect.fulfill()
    })
    
    // then
    wait(for: [expect], timeout: 0.1)
  }

  func test_loadInvalidURL() {
    let config = MockServiceConfig()
    let expect = self.expectation(description: "Should return correct data")
    let expectedResponseData = "Response".data(using: .utf8)!
    
    let mockRequest = MockRequest(path: "ą", method: .get)
    let mockService = MockServiceRequest(data: expectedResponseData, response: nil, error: nil)
    let serviceManager = ServiceManager(config: config, session: mockService)

    _ = serviceManager.request(endpoint: mockRequest, completion: { (result) in
      do {
        _ = try result.get()
        XCTFail("Skipped")
      } catch {
        guard case ErrorResponse.invalidUrl = error else {
          XCTFail("Expect invalid url")
          return
        }
        expect.fulfill()
      }
    })

    wait(for: [expect], timeout: 0.1)
  }

  func test_failedLoad() {
    let config = MockServiceConfig()
    let expect = self.expectation(description: "Should return hasStatusCode error")
    let cancelledError = NSError(domain: "network", code: NSURLErrorCancelled, userInfo: nil)
    
    let mockRequest = MockRequest(path: "https://test.com", method: .get)
    let mockService = MockServiceRequest(data: nil, response: nil, error: cancelledError as Error)
    let serviceManager = ServiceManager(config: config, session: mockService)
  
    _ = serviceManager.request(endpoint: mockRequest) { (result) in
      do {
        _ = try result.get()
        XCTFail("Skipped")
      } catch {
        guard case ErrorResponse.cancelled = error else {
          XCTFail("Expect error cancelled")
          return
        }
        expect.fulfill()
      }
    }

    // then
    wait(for: [expect], timeout: 0.1)
  }

  func test_failedLoadWithStatusCode() {
    let config = MockServiceConfig()
    let expect = self.expectation(description: "Should return hasStatusCode error")
    let mockResponse = HTTPURLResponse(url: URL(string: "test")!,
                                       statusCode: 400,
                                       httpVersion: "1.0",
                                       headerFields: [:])
    
    let mockRequest = MockRequest(path: "https://test.com", method: .get)
    let mockService = MockServiceRequest(data: nil, response: mockResponse, error: MockErrorResponse.someError)
    let serviceManager = ServiceManager(config: config, session: mockService)

    _ = serviceManager.request(endpoint: mockRequest, completion: { (result) in
      do {
        _ = try result.get()
        XCTFail("Skipped")
      } catch {
        if case ErrorResponse.err(let statusCode,_) = error {
          XCTAssertEqual(statusCode, 400)
          expect.fulfill()
        }
      }
    })

    wait(for: [expect], timeout: 0.1)
  }

  func test_invalidConnectedNetwork() {
    let config = MockServiceConfig()
    let expect = self.expectation(description: "Should return hasStatusCode error")
    let cancelledError = NSError(domain: "network", code: NSURLErrorNotConnectedToInternet, userInfo: nil)
    
    let mockRequest = MockRequest(path: "https://test.com", method: .get)
    let mockService = MockServiceRequest(data: nil, response: nil, error: cancelledError as Error)
    let serviceManager = ServiceManager(config: config, session: mockService)

    _ = serviceManager.request(endpoint: mockRequest, completion: { (result) in
      do {
        _ = try result.get()
        XCTFail("Skipped")
      } catch {
        guard case ErrorResponse.noConnection = error else {
          XCTFail("Expect no connection error")
          return
        }
        expect.fulfill()
      }
    })
    wait(for: [expect], timeout: 0.1)
  }
}
