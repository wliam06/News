//
//  HeadlineViewController.swift
//  News
//
//  Created by William on 08/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class HeadlineViewController: UITableViewController {
  var data = [Article]() {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .clear
    self.tableView.register(HeadlineCell.self, forCellReuseIdentifier: HeadlineCell.reuseIdentifier())
    self.tableView.register(ArticleItemCell.self, forCellReuseIdentifier: ArticleItemCell.reuseIdentifier())
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineCell.reuseIdentifier(), for: indexPath) as! HeadlineCell
      cell.item = data[indexPath.row]
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: ArticleItemCell.reuseIdentifier(), for: indexPath) as! ArticleItemCell
      cell.item = data[indexPath.row]
      return cell
    }
  }

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return 250
    default:
      return 140
    }
  }
}

//class HeadlineViewController: UICollectionViewController {
//  var data = [Article]() {
//    didSet {
//      self.collectionView.reloadData()
//    }
//  }
//
//  override init(collectionViewLayout layout: UICollectionViewLayout) {
//    super.init(collectionViewLayout: layout)
//  }
//
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
//    return collectionViewLayout as! UICollectionViewFlowLayout
//  }
//
//  override func viewDidLayoutSubviews() {
//    super.viewDidLayoutSubviews()
//
//    configureCollectionViewLayoutItemSize()
//  }
//
//  private func configureCollectionViewLayoutItemSize() {
//    collectionViewFlowLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width,
//                                               height: collectionViewLayout.collectionView!.frame.size.height)
//  }
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    self.view.backgroundColor = .clear
//    self.collectionView.backgroundColor = .clear
//    self.collectionView.register(HeadlineCell.self,
//                                 forCellWithReuseIdentifier: HeadlineCell.reuseIdentifier())
//  }
//
//  // MARK: UICollectionViewDataSource
//  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return data.count
//  }
//
//  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCell.reuseIdentifier(), for: indexPath) as! HeadlineCell
//    cell.item = data[indexPath.row]
//
//    let firstRow = indexPath.row == 0
//
//    switch firstRow {
//    case is HeadlineCell:
//      print("Headline item")
//    default:
//      print("Cell items")
//    }
//    return cell
//  }
//}
