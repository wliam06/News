//
//  ArticleUseCaseTests.swift
//  NewsTests
//
//  Created by William on 01/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News

private enum ArticleRepositoryError: Error {
  case failed
}

class ArticleUseCaseTests: XCTestCase {
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
    let useCase = DefaultArticleUseCase(repository: mockRepository)

    _ = useCase.requestArticle("us") { _ in
      expect.fulfill()
    }

    var data = ArticlesEntity(articles: [Article]())
    _ = mockRepository.requestTopHeadlines("us") { (result) in
      data = (try? result.get()) ?? ArticlesEntity(articles: [Article]())
      expect.fulfill()
    }

    wait(for: [expect], timeout: 0.1)
    XCTAssertTrue(data.articles.count > 0, "Expect data is exist")
  }

  func test_invalidLoadHeadline() {
    let expect = self.expectation(description: "Should data is invalid")
    expect.expectedFulfillmentCount = 2
    let mockRepository = MockArticleRepository(result: .failure(ArticleRepositoryError.failed))
    let useCase = DefaultArticleUseCase(repository: mockRepository)

    _ = useCase.requestArticle("us") { _ in
      expect.fulfill()
    }

    var data = ArticlesEntity(articles: [Article]())
    _ = mockRepository.requestTopHeadlines("us") { (result) in
      data = (try? result.get()) ?? ArticlesEntity(articles: [Article]())
      expect.fulfill()
    }

    wait(for: [expect], timeout: 0.1)
    XCTAssertTrue(data.articles.isEmpty, "Expect data is empty")
  }
}
