//
//  ServiceSession.swift
//  News
//
//  Created by William on 07/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

protocol ServiceSession {
  func load(url: URLRequest, completion: @escaping(Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: ServiceSession {
  func load(url: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      DispatchQueue.main.async {
        completion(data, response, error)
      }
    }.resume()
  }
}
