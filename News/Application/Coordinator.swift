//
//  Coordinator.swift
//  News
//
//  Created by William on 24/05/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
  var navigationController: UINavigationController { get set } // presented view
  func start() // creating
}
