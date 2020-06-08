//
//  HeadlineCell.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class HeadlineCell: UICollectionViewCell {
  var item: Article? {
    didSet {
      didSetHeadlineItem()
    }
  }

  private let headlineImageView: UIImageView = {
    return UIImageView.create(apply: { (image) in
      image.translatesAutoresizingMaskIntoConstraints = false
      image.contentMode = UIView.ContentMode.scaleToFill
      image.sizeToFit()
    })
  }()

  private let labelContainerView: UIView = {
    return UIView.create(apply: { view in
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .clear
    })
  }()

  private let stackView: UIStackView = {
    return UIStackView.create(apply: { stack in
      stack.translatesAutoresizingMaskIntoConstraints = false
      stack.axis = NSLayoutConstraint.Axis.vertical
      stack.distribution = .fill
      stack.backgroundColor = .blue
    })
  }()

  private let titleLabel: UILabel = {
    return UILabel.create(apply: { label in
      label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      label.textColor = .white
      label.numberOfLines = 2
    })
  }()

  static func reuseIdentifier() -> String {
    return String(describing: self)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    configureHeadlineImage()
    configureLabelContainer()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureHeadlineImage() {
    // Set headline image
    self.addSubview(headlineImageView)

    headlineImageView.backgroundColor = .lightGray
    NSLayoutConstraint.activate([
      headlineImageView.topAnchor.constraint(equalTo: topAnchor),
      headlineImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headlineImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      headlineImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  private func configureLabelContainer() {
    self.addSubview(labelContainerView)

    // Set label container constraint
    NSLayoutConstraint.activate([
      labelContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      labelContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      labelContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      labelContainerView.heightAnchor.constraint(equalToConstant: 64)
    ])

    labelContainerView.addSubview(stackView)
    stackView.addArrangedSubview(titleLabel)
    labelContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.6)

    stackView.backgroundColor = .blue
    // Set stackview constraint
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: labelContainerView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      stackView.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor)
    ])
  }

  private func didSetHeadlineItem() {
    guard let article = self.item else { return }
    titleLabel.text = article.title
    
    if let imageUrl = article.urlToImage {
      headlineImageView.loadImage(withUrl: imageUrl)
    }
    
  }
}
