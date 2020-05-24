//
//  ArticleListViewController.swift
//  News
//
//  Created by William on 10/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleListViewController: UIViewController {
//  private lazy var searchBar: UISearchBar = {
//    let base = UISearchBar(frame: CGRect(x: 0,
//                                         y: 0,
//                                         width: UIScreen.main.bounds.width,
//                                         height: 40))
//    base.placeholder = "Search here"
//    base.sizeToFit()
//    base.isTranslucent = false
//    return base
//  }()

//  let articleListViewModel: ArticleListViewModel?
  weak var coordinator: ArticleListCoordinator?

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

//    self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    self.view.backgroundColor = .white
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    
  }
}
