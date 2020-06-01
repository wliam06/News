//
//  ArticleListCoordinator.swift
//  News
//
//  Created by William on 24/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

protocol ArticleListDependencies {
  func loadArticleListVC() -> ArticleListViewController
}

class ArticleListCoordinator: Coordinator {
  var navigationController: UINavigationController
  private let dependencies: ArticleListDependencies

  init(navigationController: UINavigationController, dependencies: ArticleListDependencies) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }

  func start() {
    let vc = dependencies.loadArticleListVC()
    navigationController.pushViewController(vc, animated: true)
  }
}
