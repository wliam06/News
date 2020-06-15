//
//  ArticleItemCell.swift
//  News
//
//  Created by William on 15/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class ArticleItemCell: UITableViewCell {
  var item: Article? {
    didSet {
      didSetArticleItem()
    }
  }
  
  private let imageContainerView: UIView = {
    return UIView.create { (view) in
      view.translatesAutoresizingMaskIntoConstraints = false
    }
  }()

  private let articleImageView: UIImageView = {
    return UIImageView.create(apply: { (image) in
      image.translatesAutoresizingMaskIntoConstraints = false
      image.contentMode = UIView.ContentMode.scaleToFill
      image.backgroundColor = .lightGray
      image.sizeToFit()
    })
  }()

  private let vStackView: UIStackView = {
    return UIStackView.create(apply: { stack in
      stack.translatesAutoresizingMaskIntoConstraints = false
      stack.axis = NSLayoutConstraint.Axis.vertical
      stack.distribution = .fill
    })
  }()

  private let hStackView: UIStackView = {
    return UIStackView.create { (stack) in
      stack.translatesAutoresizingMaskIntoConstraints = false
      stack.axis = NSLayoutConstraint.Axis.horizontal
      stack.distribution = .fill
      stack.spacing = 8
    }
  }()

  private let titleLabel: UILabel = {
    return UILabel.create(apply: { label in
      label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
      label.numberOfLines = 0
    })
  }()

  static func reuseIdentifier() -> String {
    return String(describing: self)
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureLayout()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func configureLayout() {
    self.addSubview(hStackView)

    hStackView.addArrangedSubview(vStackView)

    NSLayoutConstraint.activate([
      hStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
      hStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      hStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
      hStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
    ])
    vStackView.addArrangedSubview(titleLabel)

    hStackView.addArrangedSubview(imageContainerView)
    
    imageContainerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
    imageContainerView.addSubview(articleImageView)

    NSLayoutConstraint.activate([
      articleImageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
      articleImageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
      articleImageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 6),
      articleImageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -6),
      articleImageView.heightAnchor.constraint(equalToConstant: 100)
    ])
  }

  private func didSetArticleItem() {
    guard let article = self.item else { return }
    titleLabel.text = article.title
    
    if let imageUrl = article.urlToImage {
      articleImageView.loadImage(withUrl: imageUrl)
    }
  }
}
