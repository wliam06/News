//
//  ArticleUseCases.swift
//  News
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

protocol ArticleUseCase: class {
  func requestArticle(_ country: String, completion: @escaping (Result<ArticlesEntity, Error>) -> Void) -> Cancelable?
}

final class DefaultArticleUseCase: ArticleUseCase {
  private let repository: ArticleRepository

  init(repository: ArticleRepository) {
    self.repository = repository
  }
  
  func requestArticle(_ country: String,
                      completion: @escaping (Result<ArticlesEntity, Error>) -> Void) -> Cancelable? {
    return repository.requestTopHeadlines(country) { (result) in
      completion(result)
    }
  }
  
}
