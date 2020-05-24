//
//  AppDIContainer.swift
//  News
//
//  Created by William on 10/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

final class AppDIContainer {
  func loadRootDIContainer() -> ArticleDIContainer {
    return ArticleDIContainer()
  }
}
