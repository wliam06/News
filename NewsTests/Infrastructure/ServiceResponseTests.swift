//
//  ServiceResponseTests.swift
//  NewsTests
//
//  Created by William on 29/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News

private enum MockErrorResponse: Error {
  case someError
}

private struct MockModel: Decodable {
  let name: String
}

class ServiceResponseTests: XCTestCase {
  func test_successResponse() {
    let config = MockServiceConfig()
    let expect = self.expectation(description: "Should decodable object")
    let expectedResponseData = #"{"name": "Test"}"#.data(using: .utf8)
    
    let mockService = MockServiceRequest(data: expectedResponseData, response: nil, error: nil)
    let serviceManager = ServiceManager(config: config, session: mockService)
    let endpoint = Endpoint<MockModel>(path: "https://test.com")
    let response = ServiceResponse(session: serviceManager)
    
    _ = response.request(withEndpoint: endpoint, completion: { (result) in
      do {
        let data = try result.get()
        XCTAssertEqual(data.name, "Test")
        expect.fulfill()
      } catch {
        XCTFail("Failed decode model")
      }
    })

    wait(for: [expect], timeout: 0.1)
  }

  func test_invalidResponseObject() {
    let config = MockServiceConfig()
    let expect = self.expectation(description: "Should not decode")
    let expectedResponseData = #"{"class": "1 A"}"#.data(using: .utf8)

    let mockService = MockServiceRequest(data: expectedResponseData, response: nil, error: nil)
    let serviceManager = ServiceManager(config: config, session: mockService)
    let endpoint = Endpoint<MockModel>(path: "https://test.com")
    let response = ServiceResponse(session: serviceManager)

    _ = response.request(withEndpoint: endpoint, completion: { (result) in
      do {
        _ = try result.get()
        XCTFail("Skipped")
      } catch {
        expect.fulfill()
      }
    })

    wait(for: [expect], timeout: 0.1)
  }

  func test_badRequestResponse() {
    let config = MockServiceConfig()
    let expect = self.expectation(description: "Should not decode")
    let mockResponse = HTTPURLResponse(url: URL(string: "test")!,
                                       statusCode: 400,
                                       httpVersion: "1.0",
                                       headerFields: [:])
    let mockService = MockServiceRequest(data: nil, response: mockResponse, error: MockErrorResponse.someError)
    let serviceManager = ServiceManager(config: config, session: mockService)
    let endpoint = Endpoint<MockModel>(path: "https://test.com")
    let response = ServiceResponse(session: serviceManager)

    _ = response.request(withEndpoint: endpoint, completion: { (result) in
      do {
        _ = try result.get()
        XCTFail("Skipped")
      } catch {
        if case DataErrorType.networkInvalid(ErrorResponse.err(statusCode: 400, data: _)) = error {
          expect.fulfill()
        } else {
          XCTFail("Invalid response")
        }
      }
    })
  
    wait(for: [expect], timeout: 0.1)
  }
}
