
//
//  ServiceManager.swift
//  News
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

public protocol NetworkCancellable {
  func cancel()
}

extension URLSessionTask: NetworkCancellable {}

final class ServiceManager {
  private let config: BaseServiceConfig
  private let session: ServiceRequest

  public init(config: BaseServiceConfig, session: ServiceRequest = ServiceSessionRequest()) {
    self.config = config
    self.session = session
  }

  private func load(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
    let task = session.request(request: request) { (data, response, error) in
      if let error = error {
        var err: ErrorResponse
        if let response = response as? HTTPURLResponse {
          err = .err(statusCode: response.statusCode, data: data)
        } else {
          err = self.convertedError(error: error)
        }
      } else {
        completion(.success(data))
      }
    }

    return task
  }
  
  private func convertedError(error: Error) -> ErrorResponse {
    let code = URLError.Code(rawValue: (error as NSError).code)
    switch code {
    case .notConnectedToInternet: return .noConnection
    case .cancelled: return .cancelled
    default:
      return .base(error)
    }
  }
}

extension ServiceManager: ServiceSession {
  func request(endpoint: Request, completion: @escaping CompletionHandler) -> NetworkCancellable? {
    do {
      let urlRequest = try endpoint.urlRequest(config: config)
      return self.load(request: urlRequest, completion: completion)
    } catch {
      completion(.failure(.invalidUrl))
      return nil
    }
  }
}
