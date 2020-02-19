//
//  GAStrokeLabel.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAStrokeLabel: UILabel {
    
    @IBInspectable var fontSize: CGFloat = 10
    @IBInspectable var strokeColor: UIColor = UIColor.white
    
    override func draw(_ rect: CGRect) {
        
        let scale = 1.0 / UIScreen.main.scale
        let w: CGFloat = rect.size.width
        let h: CGFloat = rect.size.height
        
        let path = UIBezierPath.init()
        path.move(to: CGPoint.p(0, 0))
        path.addLine(to: CGPoint.p(w, 0))
        path.addLine(to: CGPoint.p(w, h))
        path.addLine(to: CGPoint.p(0, h))
        path.addLine(to: CGPoint.p(0, 0))
        path.lineWidth = scale
        
        strokeColor.setStroke()
        path.stroke()
        
        let s: NSString = (self.text ?? "") as NSString
        let textW = self.text?.ga_widthWith(fontSize, height: fontSize) ?? 0
        let textAttributes: [NSAttributedString.Key : Any] = [.font : self.font ?? UIFont.systemFont(ofSize: fontSize), .foregroundColor : self.textColor ?? UIColor.lightGray]
        s.draw(at: CGPoint(x: w / 2 - textW / 2, y: h / 2 - fontSize / 2), withAttributes: textAttributes)
    }
    
    
}
