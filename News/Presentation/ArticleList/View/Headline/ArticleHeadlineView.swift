//
//  ArticleHeadlineView.swift
//  News
//
//  Created by William on 01/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

class HeadlineView: UITableView {
  var data: [Article] = [Article]() {
    didSet {
        DispatchQueue.main.async { [weak self] in
          self?.reloadData()
      }
    }
  }

  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    self.delegate = self
    self.dataSource = self

    self.rowHeight = 240
    self.register(HeadlineCell.self, forCellReuseIdentifier: HeadlineCell.reuseIdentifier())
  }
}

extension HeadlineView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineCell.reuseIdentifier(), for: indexPath) as! HeadlineCell
    cell.item = data[indexPath.row]
    return cell
  }
}
