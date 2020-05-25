//
//  DictionaryExtension.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import Foundation

extension Dictionary {
  var queryString: String {
    return self.map { "\($0.key)=\($0.value)" }
      .joined(separator: "&")
      .addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
  }
}
