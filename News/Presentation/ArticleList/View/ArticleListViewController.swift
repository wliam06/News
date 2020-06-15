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

  private let headlineVC: HeadlineViewController = {
    let view = HeadlineViewController(style: .plain)
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

    configureTopHeadlineView()
  }

  private func bind(to viewModel: ArticleListViewModel) {
    viewModel.topHeadlines.observe(on: self, observerBlock: { [weak self] in self?.headlineVC.data = $0 })
  }

  private func configureTopHeadlineView() {
    // Configure topHeadlineVC
    let containerView = UIView(frame: .zero)
    containerView.frame = self.view.bounds
    self.addChild(headlineVC)

    headlineVC.didMove(toParent: self)
    headlineVC.view.frame = containerView.frame
    headlineVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    containerView.addSubview(headlineVC.view)
    view.addSubview(containerView)
  }
}
