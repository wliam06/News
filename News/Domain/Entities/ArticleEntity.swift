//
//  ArticleEntity.swift
//  News
//
//  Created by William on 24/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

struct ArticlesEntity: Equatable {
  let articles: [Article]
}

struct Article: Equatable, Identifiable {
  let id: String?
  let title: String
  let description: String?
  let url: String
  let urlToImage: String?
}
