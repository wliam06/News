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

  private let headlineView: HeadlineView = {
    let view = HeadlineView(frame: .zero, style: .plain)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: - Initialize
  static func initiate(viewModel: ArticleListViewModel) -> ArticleListViewController {
    let view = ArticleListViewController()
    view.viewModel = viewModel
    return view
  }

  // MARK: - Life cycle
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    title = "Headline News"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white

    // Request top headlines based on country
    if let country = NSLocale.current.regionCode {
      viewModel.requestTopHeadlines(country)
    }

    bind(to: viewModel)

    // Add child view
    self.view.addSubview(headlineView)

    NSLayoutConstraint.activate([
      headlineView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
      headlineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      headlineView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      headlineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
    ])
  }

  private func bind(to viewModel: ArticleListViewModel) {
    viewModel.topHeadlines.observe(on: self, observerBlock: { [weak self] in self?.headlineView.data = $0 })
  }
}
