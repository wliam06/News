//
//  ServiceError.swift
//  News
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

// MARK: - Error Response Request
public enum ErrorResponse: Error {
  case err(statusCode: Int, data: Data?)
  case noConnection
  case cancelled
  case invalidUrl
  case base(Error)
}

extension ErrorResponse {
  public var notFoundError: Bool { return statusCode(404) }

  public func statusCode(_ code: Int) -> Bool {
    switch self {
    case let.err(code, _):
      return code == code
    default: return false
    }
  }
}

// MARK: -  Service Error Data
public enum DataErrorType: Error {
  case noResponse
  case parsing(Error)
  case networkInvalid(ErrorResponse)
  case connectionError(Error)
}

public protocol DataError {
  func err(error: ErrorResponse) -> Error
}

public final class ServiceErrorResponse: DataError {
  public init() {}
  
  public func err(error: ErrorResponse) -> Error {
    return error
  }
}
