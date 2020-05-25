//
//  ViewExtension.swift
//  News
//
//  Created by William on 25/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

extension UIView {
  @inline(__always) static func create<T>(apply: ((T) -> Void)? = nil) -> T where T: UIView {
    let view = T(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    apply?(view)
    return view
  }
}
