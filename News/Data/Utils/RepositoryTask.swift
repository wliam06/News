//
//  RepositoryTask.swift
//  News
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

public protocol Cancelable: class {
  func cancel()
}

class RepositoryTask: Cancelable {
  var request: NetworkCancelable?
  var isCancelled = false

  func cancel() {
    request?.cancel()
    isCancelled = true
  }
}
