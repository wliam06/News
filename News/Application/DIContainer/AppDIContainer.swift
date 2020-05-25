//
//  AppDIContainer.swift
//  News
//
//  Created by William on 10/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

final class AppDIContainer {
  lazy var appConfiguration = AppConfiguration()

  lazy var serviceResponse: DataService = {
    let config = ServiceConfig(baseURL: URL(string: appConfiguration.apiBaseUrl)!,
                               parameters: ["apiKey": appConfiguration.apiKey])
    let serviceManager = ServiceManager(config: config)
    return ServiceResponse(session: serviceManager)
  }()

  func loadArticleDIContainer() -> ArticleDIContainer {
    let resource = Resource(dataService: serviceResponse)
    return ArticleDIContainer(resource: resource)
  }
}
