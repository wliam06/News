//
//  MockURLResponse.swift
//  NewsTests
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
class MockURLResponse: HTTPURLResponse {
  init?(code: Int) {
    guard let url = URL(string: "https://newsapi.org/v2") else {
      return nil
    }
    
    super.init(url: url, statusCode: code, httpVersion: nil, headerFields: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
