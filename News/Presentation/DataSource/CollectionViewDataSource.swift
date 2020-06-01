//
//  CollectionViewDataSource.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Cell: UICollectionViewCell, ViewModel>: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
  private var identifier: String
  private var data: [Article]
  var configureCell: (Cell, Article) -> ()

  init(reuseIdentifier identifier: String, data: [Article], configureCell: @escaping(Cell, Article) -> ()) {
    self.data = data
    self.identifier = identifier
    self.configureCell = configureCell
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! Cell
    let item = self.data[indexPath.row]
    self.configureCell(cell, item)
    return cell
  }
}
