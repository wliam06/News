//
//  ArticleDIContainer.swift
//  News
//
//  Created by William on 10/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

struct Resource {
  let dataService: DataService
}

final class ArticleDIContainer {
  private let resource: Resource

  init(resource: Resource) {
    self.resource = resource
  }
  
  func loadArticleListVC() -> ArticleListViewController {
    return ArticleListViewController.initiate(viewModel: ArticleListViewModel())
  }

  // Coordinator
  func loadArticleListCoordinator(navigationController: UINavigationController) -> ArticleListCoordinator {
    return ArticleListCoordinator(navigationController: navigationController)
  }
}
