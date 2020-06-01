//
//  ViewControllerExtension.swift
//  News
//
//  Created by William on 31/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

@nonobjc extension UIViewController {
  func add(_ child: UIViewController, frame: CGRect? = nil, contentView: UIView) {
    addChild(child)

    if let frame = frame {
      child.view.frame = frame
    }

    view.addSubview(child.view)
    child.didMove(toParent: self)

    contentView.addSubview(child.view)
   }

   func remove() {
     willMove(toParent: nil)
     view.removeFromSuperview()
     removeFromParent()
   }
}
