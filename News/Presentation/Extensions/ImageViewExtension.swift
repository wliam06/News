//
//  ImageViewExtension.swift
//  News
//
//  Created by William on 01/06/20.
//  Copyright © 2020 William. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
  func loadImage(withUrl urlString : String) {
    let stringWithPercent = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let url = URL(string: stringWithPercent)
    self.image = nil
    
    // check cached image
    if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
      self.image = cachedImage
      return
    }
    
    // if not, download image from url
    guard let urlExist = url else { return }
    URLSession.shared.dataTask(with: urlExist, completionHandler: { (data, response, error) in
      if let error = error {
        #if DEBUG
        debugPrint("error load image", error)
        #endif
        return
      }

      DispatchQueue.main.async {
        if let image = UIImage(data: data!) {
          imageCache.setObject(image, forKey: urlString as NSString)
          self.image = image
        }
      }
      
    }).resume()
  }
}
