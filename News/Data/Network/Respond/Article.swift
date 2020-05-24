//
//  Article.swift
//  News
//
//  Created by William on 24/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

struct Headlines: Codable {
  let articles: Articles
}

struct Sources: Codable {
  let sources: ArticleSources
}

struct Articles: Codable {
  let source: ArticleSources
  let title: String
  let description: String
  let url: String
  let urlToImage: String
  let publishedAt: String
}

struct ArticlesSource: Codable {
  let id: String?
  let name: String
}

struct ArticleSources: Codable {
  let id: String
  let name: String
  let description: String
  let url: String
}
