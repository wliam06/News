//
//  HeadlineViewController.swift
//  News
//
//  Created by William on 08/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class HeadlineViewController: UICollectionViewController {
  var data = [Article]() {
    didSet {
      self.collectionView.reloadData()
    }
  }

  override init(collectionViewLayout layout: UICollectionViewLayout) {
    super.init(collectionViewLayout: layout)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private var collectionViewFlowLayout: UICollectionViewFlowLayout {
    return collectionViewLayout as! UICollectionViewFlowLayout
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    configureCollectionViewLayoutItemSize()
  }

  private func configureCollectionViewLayoutItemSize() {
    collectionViewFlowLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width,
                                               height: collectionViewLayout.collectionView!.frame.size.height)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .clear
    self.collectionView.backgroundColor = .clear
    self.collectionView.register(HeadlineCell.self,
                                 forCellWithReuseIdentifier: HeadlineCell.reuseIdentifier())
  }

  // MARK: UICollectionViewDataSource
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCell.reuseIdentifier(), for: indexPath) as! HeadlineCell
    cell.item = data[indexPath.row]
    return cell
  }
}
