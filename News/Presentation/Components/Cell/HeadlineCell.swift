//
//  HeadlineCell.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class HeadlineCell: UICollectionViewCell {
  private let headlineImageView: UIImageView = {
    return UIImageView.create(apply: { (image) in
      image.translatesAutoresizingMaskIntoConstraints = false
      image.contentMode = UIView.ContentMode.scaleToFill
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
    })
  }()

  private let titleLabel: UILabel = {
    return UILabel.create(apply: { label in
      label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
      label.adjustsFontSizeToFitWidth = true
      label.minimumScaleFactor = 0.8
    })
  }()

  static func reuseIdentifier() -> String {
    return String(describing: self)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    configureHeadlineImage()
    configureLabelContainer()
  }

  private func configureHeadlineImage() {
    self.addSubview(headlineImageView)

    NSLayoutConstraint.activate([
      headlineImageView.topAnchor.constraint(equalTo: topAnchor),
      headlineImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
      headlineImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      headlineImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }

  private func configureLabelContainer() {
    self.addSubview(labelContainerView)

    // Add stackView
    labelContainerView.addSubview(setStackView())

    NSLayoutConstraint.activate([
      labelContainerView.topAnchor.constraint(equalTo: topAnchor),
      labelContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      labelContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
      labelContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      labelContainerView.heightAnchor.constraint(equalToConstant: 64)
    ])
  }

  private func setStackView() -> UIStackView {
    stackView.addArrangedSubview(titleLabel)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: labelContainerView.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: labelContainerView.leadingAnchor, constant: 16),
      stackView.bottomAnchor.constraint(equalTo: labelContainerView.bottomAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: labelContainerView.trailingAnchor, constant: 16)
    ])
    return stackView
  }
}
