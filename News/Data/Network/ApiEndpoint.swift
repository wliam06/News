//
//  ApiEndpoint.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

struct ApiEndpoint {
  static func getHeadline(param: TopHeadlineDTO) -> Endpoint<TopHeadlineDTO> {
    return Endpoint(path: "/top-headlines", queryParametersEncodable: param)
  }
}
