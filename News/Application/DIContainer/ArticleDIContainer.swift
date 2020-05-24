//
//  ArticleDIContainer.swift
//  News
//
//  Created by William on 10/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

final class ArticleDIContainer {
  // Coordinator
  func loadArticleListCoordinator(navigationController: UINavigationController) -> ArticleListCoordinator {
    return ArticleListCoordinator(navigationController: navigationController)
  }
}
