//
//  AppFlowCoordinator.swift
//  News
//
//  Created by William on 10/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class AppFlowCoordinator: Coordinator {
  var navigationController: UINavigationController

  private let appDIContainer: AppDIContainer

  init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
    self.navigationController = navigationController
    self.appDIContainer = appDIContainer
  }
  
  func start() {
    let articleDIContainer = appDIContainer.loadRootDIContainer()
    let flow = articleDIContainer.loadArticleListCoordinator(navigationController: navigationController)
    flow.start()
  }

  func articleList() {
    let child = ArticleListCoordinator(navigationController: navigationController)
    child.parentCoordinator = self
    child.start()
  }
}
