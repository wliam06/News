//
//  ArticleRepository.swift
//  News
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

final class DefaultArticleRepository: ArticleRepository {
  private let service: DataService

  init(service: DataService) {
    self.service = service
  }

  // MARK: - Interface
  func requestTopHeadlines(_ country: String, completion: @escaping OnSuccess<ArticlesEntity>) -> Cancelable? {
    let request = TopHeadlineParams(country: country)
    let task = RepositoryTask()

    let endpoint = ApiEndpoint.getHeadline(param: request)
    task.request = service.request(withEndpoint: endpoint, completion: { (result) in
      switch result {
      case .success(let data):
        completion(.success(data.toDomain()))
      case.failure(let error):
        completion(.failure(error))
      }
    })
    return task
  }

}
