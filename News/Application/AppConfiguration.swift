//
//  AppConfiguration.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

final class AppConfiguration {
  lazy var apiKey: String = {
    guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
      fatalError("API_KEY is missing")
    }
    return apiKey
  }()

  lazy var apiBaseUrl: String = {
    guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
      fatalError("BASE_URL is missing")
    }
    return baseUrl
  }()
}
