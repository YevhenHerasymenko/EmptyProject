//
//  UIImage.swift
//  ukmdm
//
//  Created by YevhenHerasymenko on 11/29/17.
//  Copyright © 2017 UK MDM. All rights reserved.
//

import UIKit

extension UIImage {

  /**
   Additional method for UIView for creating snapshots

   - parameter view: view for creating snapshot
 */
  static func create(with view: UIView) -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
    return renderer.image { context in
      view.layer.render(in: context.cgContext)
    }
  }

  /**
   There is no default method for creating UIImage with specific background. THis method is solution for for this
   problem

   - parameter color: color for UIImage
 */
  class func image(withColor color: UIColor) -> UIImage {
    let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
  }

}
