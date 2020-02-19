//
//  Color.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

extension Int {
    var color: UIColor {
        let r = CGFloat(((self & 0xFF0000) >> 16))/255.0
        let g = CGFloat(((self & 0xFF00) >> 8))/255.0
        let b = CGFloat((self & 0xFF))/255.0
        return UIColor(red: r, green: g, blue: b, alpha: 1)
    }
    
    func color(withAlpha alpha: CGFloat = 1) -> UIColor {
        let r = CGFloat(((self & 0xFF0000) >> 16))/255.0
        let g = CGFloat(((self & 0xFF00) >> 8))/255.0
        let b = CGFloat((self & 0xFF))/255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
}

