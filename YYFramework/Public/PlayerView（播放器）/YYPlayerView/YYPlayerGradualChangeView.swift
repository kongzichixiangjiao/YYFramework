//
//  YYPlayerGradualChangeView.swift
//  YYPlayer
//
//  Created by 侯佳男 on 2018/5/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//  渐变视图

import UIKit

public class YYPlayerGradualChangeView: UIView {
    
    @IBInspectable var isUpDeep: Bool = false
    @IBInspectable var upColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    @IBInspectable var downColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    var gradientLayer: CAGradientLayer!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        
        gradientLayer = initGradientLayer()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.addSublayer(self.gradientLayer)
        self.gradientLayer.frame = self.layer.bounds
    }
    
    func initGradientLayer() -> CAGradientLayer {
        if let g = gradientLayer {
            return g
        }
        let g = CAGradientLayer()
        let colors = [
            upColor.cgColor,
            downColor.cgColor,
            ]
        let locations = [
            0.0, 1
        ]
        g.colors = colors
        g.locations = locations as [NSNumber]
        let startPoint = self.isUpDeep ? CGPoint(x: 0.5, y: 0) : CGPoint(x: 0.5, y: 1)
        let endPoint = self.isUpDeep ? CGPoint(x: 0.5, y: 1) : CGPoint(x: 0.5, y: 0)
        g.startPoint = startPoint
        g.endPoint = endPoint
        
        gradientLayer = g
        
        return g
    }
}

//- 0 : <CGColor 0x283b79e00> [<CGColorSpace 0x283a49da0> (kCGColorSpaceICCBased; kCGColorSpaceModelRGB; sRGB IEC61966-2.1; extended range)] ( 0.931684 0.24712 0.222788 0.438731 )
//- 1 : <CGColor 0x283b7a1c0> [<CGColorSpace 0x283a49da0> (kCGColorSpaceICCBased; kCGColorSpaceModelRGB; sRGB IEC61966-2.1; extended range)] ( 0.999912 1.00002 0.999883 0.507518 )
