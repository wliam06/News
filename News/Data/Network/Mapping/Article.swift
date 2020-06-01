//
//  Article.swift
//  News
//
//  Created by William on 24/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

struct Headlines: Codable {
  let articles: [Articles]
}

struct Sources: Codable {
  let sources: [ArticleSources]
}

extension Headlines {
  struct Articles: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    private enum CodingKeys: String, CodingKey {
      case source
      case title
      case description
      case url
      case urlToImage
      case publishedAt
      case content
    }
  }
}

extension Sources {
  struct ArticleSources: Codable {
    let id: String?
    let name: String
    let description: String
    let url: String
  }
}

struct Source: Codable {
  let id: String?
  let name: String
}

extension Headlines {
  func toDomain() -> ArticlesEntity {
    return .init(articles: articles.map({$0.toDomain()}))
  }
}

extension Headlines.Articles {
  public func toDomain() -> Article {
    return .init(id: source.id,
                 title: title,
                 description: description,
                 url: url,
                 urlToImage: urlToImage)
  }
}
