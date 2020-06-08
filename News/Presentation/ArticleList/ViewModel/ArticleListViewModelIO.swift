//
//  ArticleListViewModelIO.swift
//  News
//
//  Created by William on 24/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

protocol ArticleListViewModelInput: class {
  func requestTopHeadlines(_ country: String)
}

protocol ArticleListViewModelOutput: class {
  var topHeadlines: Observable<[Article]> { get }
}

protocol ArticleListViewModelIO: ArticleListViewModelInput, ArticleListViewModelOutput {}
