//
//  CGRect+Extension.swift
//  Need
//
//  Created by houjianan on 2020/3/21.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

extension CGRect {

    func ga_widthChang(_ f: CGFloat) -> CGRect {
        let x = self.origin.x
        let y = self.origin.y
        let w = self.size.width + f
        let h = self.size.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
    func ga_heightChang(_ f: CGFloat) -> CGRect {
        let x = self.origin.x
        let y = self.origin.y
        let w = self.size.width
        let h = self.size.height + f
        return CGRect(x: x, y: y, width: w, height: h)
    }
    func ga_xChang(_ f: CGFloat) -> CGRect {
        let x = self.origin.x + f
        let y = self.origin.y
        let w = self.size.width
        let h = self.size.height

        return CGRect(x: x, y: y, width: w, height: h)
    }
    func ga_yChang(_ f: CGFloat) -> CGRect {
        let x = self.origin.x
        let y = self.origin.y + f 
        let w = self.size.width
        let h = self.size.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    func ga_widthChangTo(_ f: CGFloat) -> CGRect {
        let x = self.origin.x
        let y = self.origin.y
        let w = f
        let h = self.size.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
    func ga_heightChangTo(_ f: CGFloat) -> CGRect {
        let x = self.origin.x
        let y = self.origin.y
        let w = self.size.width
        let h = f
        return CGRect(x: x, y: y, width: w, height: h)
    }
    func ga_xChangTo(_ f: CGFloat) -> CGRect {
        let x = f
        let y = self.origin.y
        let w = self.size.width
        let h = self.size.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
    func ga_yChangTo(_ f: CGFloat) -> CGRect {
        let x = self.origin.x
        let y = f
        let w = self.size.width
        let h = self.size.height
        return CGRect(x: x, y: y, width: w, height: h)
    }
}
