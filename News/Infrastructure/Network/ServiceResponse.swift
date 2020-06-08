//
//  ServiceResponse.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

public typealias OnSuccess<T> = (Result<T, Error>) -> Void

public protocol ResponseDecoder {
  func decode<T: Decodable>(_ data: Data) throws -> T
}

public protocol DataService {
  typealias CompletionHandler<T> = (Result<T, DataErrorType>) -> Void
  
  @discardableResult
  func request<T: Decodable, E: ResponseRequest>(withEndpoint endpoint: E,
                                                 completion: @escaping CompletionHandler<T>) -> NetworkCancelable? where E.Response == T

  // Request image url
  @discardableResult
  func request<E: ResponseRequest>(withEndpoint endpoint: E,
                                   completion: @escaping CompletionHandler<Void>) -> NetworkCancelable? where E.Response == Void
}

// MARK: - Service Response
public final class ServiceResponse: DataService {
  private let session: ServiceSession
  private let errorResponse: DataError

  init(session: ServiceSession, errorResponse: DataError = ServiceErrorResponse()) {
    self.session = session
    self.errorResponse = errorResponse
  }

  public func request<T, E>(withEndpoint endpoint: E,
                            completion: @escaping (Result<T, DataErrorType>) -> Void) -> NetworkCancelable? where T : Decodable, T == E.Response, E : ResponseRequest {
    return self.session.request(endpoint: endpoint, completion: { (response) in
      switch response {
      case .success(let data):
        let result: Result<T, DataErrorType> = self.decode(data: data, decoder: endpoint.responseDecoder)
        DispatchQueue.main.async {
          return completion(result)
        }
      case .failure(let error):
        let error = self.convertedError(error: error)
        DispatchQueue.main.async {
          return completion(.failure(error))
        }
      }
    })
  }

  public func request<E>(withEndpoint endpoint: E,
                         completion: @escaping CompletionHandler<Void>) -> NetworkCancelable? where E : ResponseRequest, E.Response == Void {
    return self.session.request(endpoint: endpoint, completion: { (response) in
      switch response {
      case .success(_):
        DispatchQueue.main.async {
          return completion(.success(()))
        }
      case .failure(let error):
        let err = self.convertedError(error: error)
        DispatchQueue.main.async {
          return completion(.failure(err))
        }
      }
    })
  }

  // MARK: - Private methods
  private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataErrorType> {
    do {
      guard let data = data else { return .failure(.noResponse) }
      let result: T = try decoder.decode(data)
      return .success(result)
    } catch {
      return .failure(.parsing(error))
    }
  }

  private func convertedError(error: ErrorResponse) -> DataErrorType {
    let err = self.errorResponse.err(error: error)
    return err is ErrorResponse ? .networkInvalid(error) : .connectionError(err)
  }
}

public class JsonResponseDecoder: ResponseDecoder {
  private let decoder = JSONDecoder()
  public init() {}

  public func decode<T>(_ data: Data) throws -> T where T : Decodable {
    return try decoder.decode(T.self, from: data)
  }
}
