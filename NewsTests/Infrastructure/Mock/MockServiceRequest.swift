//
//  MockServiceRequest.swift
//  NewsTests
//
//  Created by William on 28/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
struct MockServiceRequest: ServiceRequest {
  let data: Data?
  let response: HTTPURLResponse?
  let error: Error?
  
  func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancelable {
    completion(data, response, error)
    return URLSessionTask()
  }
  
}
