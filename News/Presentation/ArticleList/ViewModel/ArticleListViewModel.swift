//
//  ArticleListViewModel.swift
//  News
//
//  Created by William on 10/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

struct ArticleListViewModelClosures {
  let showArticleDetail: (Article) -> Void
}

class ArticleListViewModel: ArticleListViewModelIO {
  private var headlinesArticle = [Article]()
  private let useCase: ArticleUseCase

  // MARK: - Output
  var topHeadlines: Observable<[Article]> = Observable([])

  private var loadTask: Cancelable? {
    willSet {
      loadTask?.cancel()
    }
  }

  init(useCase: ArticleUseCase) {
    self.useCase = useCase
  }
  
  // MARK: - Input
  func requestTopHeadlines(_ country: String) {
    loadTask = useCase.requestArticle(country, completion: { (result) in
      switch result {
      case .success(let data):
        self.topHeadlines.value = data.articles
      case .failure(let error):
        print(error.localizedDescription)
      }
    })
  }
}
