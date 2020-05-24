//
//  ArticleListCoordinator.swift
//  News
//
//  Created by William on 24/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleListCoordinator: Coordinator {
  weak var parentCoordinator: AppFlowCoordinator?
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    let vc = ArticleListViewController()
    navigationController.pushViewController(vc, animated: true)
  }
}
