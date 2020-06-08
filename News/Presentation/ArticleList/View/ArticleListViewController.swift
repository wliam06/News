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

//  private let headlineView: HeadlineView = {
//    let view = HeadlineView(frame: .zero, style: .plain)
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//  }()

  private let scrollView: UIScrollView = {
    let view = UIScrollView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let stackView: UIStackView = {
    let view = UIStackView(frame: .zero)
    view.axis = NSLayoutConstraint.Axis.vertical
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private let headlineVC: HeadlineViewController = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let view = HeadlineViewController(collectionViewLayout: layout)
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

    configureScrollView()

    configureStackView()

    configureTopHeadlineView()

    stackView.addArrangedSubview(UIView(frame: .zero))
  }

  private func bind(to viewModel: ArticleListViewModel) {
    viewModel.topHeadlines.observe(on: self, observerBlock: { [weak self] in self?.headlineVC.data = $0 })
  }

  private func configureScrollView() {
    // Set scroll view
    self.view.addSubview(scrollView)

    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    scrollView.contentInsetAdjustmentBehavior = .never
  }

  private func configureStackView() {
    // Configure stackView
    scrollView.addSubview(stackView)

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
      stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1)
    ])

    stackView.backgroundColor = .red
  }

  private func configureTopHeadlineView() {
    // Configure topHeadlineVC
    let containerView = UIView(frame: .zero)
    containerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    containerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

    self.addChild(headlineVC)

    headlineVC.didMove(toParent: self)
    headlineVC.view.frame = containerView.frame
    headlineVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    containerView.addSubview(headlineVC.view)
    stackView.addArrangedSubview(containerView)
  }
}
