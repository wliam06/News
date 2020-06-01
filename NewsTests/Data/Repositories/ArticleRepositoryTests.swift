//
//  ArticleRepositoryTests.swift
//  NewsTests
//
//  Created by William on 01/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
class ArticleRepositoryTests: XCTestCase {
  static let mockArticle = Article(id: "1",
                            title: "News title",
                            description: "News Description",
                            url: "https://test.com",
                            urlToImage: nil)
  let mockData = ArticlesEntity(articles: [ArticleUseCaseTests.mockArticle])

  func test_successLoadHeadline() {
    let expect = self.expectation(description: "Should return [Article] data")
    expect.expectedFulfillmentCount = 2
    let mockRepository = MockArticleRepository(result: .success(mockData))
    
  }
}
