//
//  MockArticleRepository.swift
//  NewsTests
//
//  Created by William on 01/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import XCTest

@testable import News
struct MockArticleRepository: ArticleRepository {
  var result: Result<ArticlesEntity, Error>

  func requestTopHeadlines(_ country: String, completion: @escaping OnSuccess<ArticlesEntity>) -> Cancelable? {
    completion(result)
    return nil
  }
}
