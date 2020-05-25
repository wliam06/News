//
//  ServiceSession.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

public protocol ServiceSession {
  typealias CompletionHandler = (Result<Data?, ErrorResponse>) -> Void
  func request(endpoint: Request, completion: @escaping CompletionHandler) -> NetworkCancellable?
}

public protocol ServiceRequest {
  typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
  func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable
}

public class ServiceSessionRequest: ServiceRequest {
  public init() {}

  public func request(request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
    let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
    task.resume()
    return task
  }
}
