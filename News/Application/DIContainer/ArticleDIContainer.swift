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

  // MARK: - Repository
  func loadArticleRepository() -> ArticleRepository {
    return DefaultArticleRepository(service: resource.dataService)
  }

  // MARK: - UseCase
  func loadArticleUseCase() -> ArticleUseCase {
    return DefaultArticleUseCase(repository: loadArticleRepository())
  }

  // MARK: - View Model
  func loadArticleViewModel() -> ArticleListViewModel {
    return ArticleListViewModel(useCase: loadArticleUseCase())
  }

  // MARK: - View Controller
  func loadArticleListVC() -> ArticleListViewController {
    return ArticleListViewController.initiate(viewModel: loadArticleViewModel())
  }

  // MARK: - Coordinator
  func loadArticleListCoordinator(navigationController: UINavigationController) -> ArticleListCoordinator {
    return ArticleListCoordinator(navigationController: navigationController, dependencies: self)
  }
}

extension ArticleDIContainer: ArticleListDependencies {}
