//
//  ArticleDetailCoordinator.swift
//  News
//
//  Created by William on 08/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleDetailCoordinator: Coordinator {
  var navigationController: UINavigationController
  private let dependencies: ArticleListDependencies

  init(navigationController: UINavigationController, dependencies: ArticleListDependencies) {
    self.navigationController = navigationController
    self.dependencies = dependencies
  }

  func start() {
    let vc = dependencies.loadArticleListVC() // load article detail vc
    navigationController.pushViewController(vc, animated: true)
  }
}
