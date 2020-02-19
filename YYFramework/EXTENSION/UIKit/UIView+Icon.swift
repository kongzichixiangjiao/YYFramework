//
//  UIView+Icon.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/9.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

enum UIViewIconDirection: Int {
    case left = 1, right = 2, top = 3, bottom = 4
}

extension UIView {
    
    // self.layer.masksToBounds -> false
    func ga_addIcon(named: String, direction: UIViewIconDirection = .right, space: CGFloat = 5) {
        guard let icon = UIImage(named: named) else {
            return
        }
        let vW: CGFloat = self.frame.size.width
        let vH: CGFloat = self.frame.size.height
        let w: CGFloat = icon.size.width
        let h: CGFloat = icon.size.height
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        switch direction {
        case .left:
            x = -(w + space)
            y = (vH - h) / 2
            break
        case .right:
            x = vW + space
            y = (vH - h) / 2
            break
        case .top:
            x = (vW - w) / 2
            y = -(h + space)
            break
        case .bottom:
            x = (vW - w) / 2
            y = vH + space
            break
        }
        
        let imgView = UIImageView(image: icon)
        imgView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        self.addSubview(imgView)
    }
    
    
    func ga_subViewAddIcon(named: String, direction: UIViewIconDirection = .right, space: CGFloat = 5) {
        guard let icon = UIImage(named: named) else {
            return
        }
        let vW: CGFloat = self.frame.size.width
        let vH: CGFloat = self.frame.size.height
        let vX: CGFloat = self.frame.origin.x
        let vY: CGFloat = self.frame.origin.y
        
        let w: CGFloat = icon.size.width
        let h: CGFloat = icon.size.height
        
        var x: CGFloat = 0
        var y: CGFloat = 0
        switch direction {
        case .left:
            x = vX - (w + space)
            y = vY + (vH - h) / 2
            break
        case .right:
            x = vX + vW + space
            y = vY + (vH - h) / 2
            break
        case .top:
            x = vX + (vW - w) / 2
            y = vY - (h + space)
            break
        case .bottom:
            x = vX + (vW - w) / 2
            y = vY + vH + space
            break
        }
        
        let imgView = UIImageView(image: icon)
        imgView.frame = CGRect(x: x, y: y, width: w, height: h)
        
        self.superview?.addSubview(imgView)
    }
    
}
