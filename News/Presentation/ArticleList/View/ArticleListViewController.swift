//
//  ArticleListViewController.swift
//  News
//
//  Created by William on 10/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {
  weak var coordinator: ArticleListCoordinator?
  private var viewModel: ArticleListViewModel!

  static func initiate(viewModel: ArticleListViewModel) -> ArticleListViewController {
    let view = ArticleListViewController()
    view.viewModel = viewModel
    return view
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    self.view.backgroundColor = .white
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}
