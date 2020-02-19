//
//  UIImage.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(withColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
}

extension UIImage {
    func resize(to size:CGSize, model: UIView.ContentMode = .scaleAspectFit) -> UIImage? {
        
        let height = size.height
        let width = size.width
        
        let scale = height/width
        
        let imageWidth = self.size.width
        let imageHeight = self.size.height
        
        let imageScale = imageHeight/imageWidth
        
        var destResolution = size
        
        if model == .scaleAspectFill {
            if imageScale > scale {
                destResolution.height = width * imageScale
            } else {
                destResolution.width = height / imageScale
            }
        } else if model == .scaleAspectFit {
            if imageScale > scale {
                destResolution.width = height / imageScale
            } else {
                destResolution.height = width * imageScale
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(destResolution, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: destResolution.width, height: destResolution.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

