//
//  ServiceError.swift
//  News
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

enum ErrorType: Error, Equatable {
  case err(message: String)
  case network
  case unexpected
}

struct ErrorRespond: Error, Equatable {
  let type: ErrorType

  var message: String {
    switch type {
    case .err(let text):
      return text
    case .network:
      return "Connection error."
    case .unexpected:
      return "An unexpected error occurred."
    }
  }

  static func == (lhs: ErrorRespond, rhs: ErrorRespond) -> Bool {
    return lhs.type == rhs.type
  }
}
