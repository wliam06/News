//
//  ArticleRepositoryInterface.swift
//  News
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

protocol ArticleRepository: class {
  @discardableResult
  func requestTopHeadlines(_ country: String, completion: @escaping OnSuccess<ArticlesEntity>) -> Cancelable?
}
