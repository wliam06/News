//
//  Endpoint.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
  case get = "GET"
}

public enum BodyEncoding {
  case jsonSerializationData
  case encodingAscii
}

private enum RequestError: Error {
  case err
}

public protocol Request {
  var path: String { get }
  var isFullPath: Bool { get }
  var method: HTTPMethod { get }
  var header: [String: String] { get }
  var queryParametersEncodable: Encodable? { get }
  var queryParameters: [String: Any] { get }
  var bodyParamatersEncodable: Encodable? { get }
  var bodyParamaters: [String: Any] { get }
  var bodyEncoding: BodyEncoding { get }

  func urlRequest(config: BaseServiceConfig) throws -> URLRequest
}

public protocol ResponseRequest: Request {
  associatedtype Response

  var responseDecoder: ResponseDecoder { get }
}

public class Endpoint<R>: ResponseRequest {
  public typealias Response = R

  public var path: String
  public var isFullPath: Bool
  public var method: HTTPMethod
  public var header: [String: String]
  public var queryParametersEncodable: Encodable? = nil
  public var queryParameters: [String: Any]
  public var bodyParamatersEncodable: Encodable? = nil
  public var bodyParamaters: [String: Any]
  public var bodyEncoding: BodyEncoding
  public var responseDecoder: ResponseDecoder

  init(path: String,
       isFullPath: Bool = false,
       method: HTTPMethod = .get,
       header: [String: String] = [:],
       queryParametersEncodable: Encodable? = nil,
       queryParameters: [String: Any] = [:],
       bodyParamatersEncodable: Encodable? = nil,
       bodyParamaters: [String: Any] = [:],
       bodyEncoding: BodyEncoding = .jsonSerializationData,
       responseDecoder: ResponseDecoder = JsonResponseDecoder()) {
    self.path = path
    self.isFullPath = isFullPath
    self.method = method
    self.header = header
    self.queryParametersEncodable = queryParametersEncodable
    self.queryParameters = queryParameters
    self.bodyParamatersEncodable = bodyParamatersEncodable
    self.bodyParamaters = bodyParamaters
    self.bodyEncoding = bodyEncoding
    self.responseDecoder = responseDecoder
  }
}

extension Request {
  public func url(config: BaseServiceConfig) throws -> URL {
    let baseURL = config.baseURL.absoluteString.last != "/" ? config.baseURL.absoluteString + "/" : config.baseURL.absoluteString
    let endpoint = isFullPath ? path : baseURL.appending(path)

    guard var urlComponents = URLComponents(string: endpoint) else {
      throw RequestError.err
    }

    var urlQueryItems = [URLQueryItem]()
    let queryParameters = try queryParametersEncodable?.toDictionary() ?? self.queryParameters
    
    queryParameters.forEach {
      urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
    }

    config.parameters.forEach {
      urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
    }

    urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil
    guard let url = urlComponents.url else { throw RequestError.err }
    return url
  }

  public func urlRequest(config: BaseServiceConfig) throws -> URLRequest {
    let url = try self.url(config: config)
    var urlRequest = URLRequest(url: url)
    var headers = config.headers
    
    headers.forEach { headers.updateValue($1, forKey: $0) }

    let params = try bodyParamatersEncodable?.toDictionary() ?? self.bodyParamaters
  
    if !params.isEmpty {
      urlRequest.httpBody = encodeBody(bodyParamaters: params, bodyEncoding: bodyEncoding)
    }
  
    urlRequest.httpMethod = method.rawValue
    urlRequest.allHTTPHeaderFields = headers
    return urlRequest
  }

  private func encodeBody(bodyParamaters: [String: Any], bodyEncoding: BodyEncoding) -> Data? {
    switch bodyEncoding {
    case .jsonSerializationData: // Moving structure from json into data
      return try? JSONSerialization.data(withJSONObject: bodyParamaters)
    case .encodingAscii: // Converted data into Unicode
      return bodyParamaters.queryString.data(using: String.Encoding.ascii, allowLossyConversion: true)
    }
  }
}
