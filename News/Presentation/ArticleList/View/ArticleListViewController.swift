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
  private var dataSource: CollectionViewDataSource<HeadlineCell, ArticleListViewModel>!

  private lazy var articleListView: ArticleListView = {
    return ArticleListView.create() { views in
      views.translatesAutoresizingMaskIntoConstraints = false
    }
  }()

  // MARK: - Initialize
  static func initiate(viewModel: ArticleListViewModel) -> ArticleListViewController {
    let view = ArticleListViewController()
    view.viewModel = viewModel
    return view
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    title = "News"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    configureLayout()
  }

  private func configureLayout() {
    // Set tableView
    view.addSubview(articleListView)

    let margins = view.layoutMarginsGuide
    NSLayoutConstraint.activate([
      articleListView.topAnchor.constraint(equalTo: margins.topAnchor),
      articleListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      articleListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      articleListView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}
