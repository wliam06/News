//
//  ServiceManager.swift
//  News
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

enum ServicePath: Equatable {
  case topHeadlines
  case everything
  case sources
  
  static func == (lhs: ServicePath?, rhs: ServicePath) -> Bool {
    guard let lhs = lhs else {
      return false
    }
    
    return lhs == lhs
  }
}

private struct Path {
  let path: String
  
  init(servicePath: ServicePath) {
    switch servicePath {
    case .topHeadlines:
      path = "/top-headlines"
    case .everything:
      path = "everything"
    case .sources:
      path = "sources"
    }
  }
}

class ServiceManager {
  private let header = ["Authorization": "Bearer 464e01ad1e634524b2895290c53510de"]
//  private let header = ["Authorization": ""]
  private let baseURL = "https://newsapi.org/v2"

  private let session: ServiceSession

  init(session: ServiceSession = URLSession.shared) {
    self.session = session
  }

  func load(_ path: ServicePath, params: [String: Any]? = nil, completion: @escaping(Data?, ErrorRespond?) -> Void) {
    let servicePath = Path(servicePath: path)

    guard let url = URL(string: baseURL + servicePath.path) else {
      completion(nil, ErrorRespond(type: .err(message: "Invalid BASEURL")))
      return
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    urlRequest.allHTTPHeaderFields = header

    if let param = params {
      urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
    }

    session.load(url: urlRequest) { (data, response, error) in
      var errorType = ErrorType.network

      guard let data = data, error == nil else {
        completion(nil, ErrorRespond(type: errorType))
        return
      }

      do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        if let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode != 200 {
          if let message = (json as? [String: Any])? ["message"] as? String {
            errorType = .err(message: message)
          } else {
            errorType = .unexpected
          }
          completion(nil, ErrorRespond(type: errorType))
          return
        }

        completion(data, nil)
        return
      } catch {
        errorType = .unexpected
        completion(nil, ErrorRespond(type: errorType))
      }

    }

  }
}
