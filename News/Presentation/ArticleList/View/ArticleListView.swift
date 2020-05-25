//
//  ArticleListView.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

final class ArticleListView: UIView {
  private lazy var collectionView: UICollectionView = {
    return UICollectionView.create() { collectionView in
      collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)

    configureLayout()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureLayout() {
    backgroundColor = .clear
    addSubview(collectionView)

    applyConstraint()
  }

  private func applyConstraint() {
    // Set scrollview constraint
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
}
