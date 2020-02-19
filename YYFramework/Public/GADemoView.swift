//
//  GADemoView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/17.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GADemoView: UIView {

    lazy var label: UILabel = {
        let v = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 20))
        v.textColor = UIColor.demo_randomColor()
        return v
    }()
    
    var text: String! {
        didSet {
            self.addSubview(label)
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.backgroundColor = UIColor.demo_randomColor()
    }
    
}

extension UIColor {
    static func demo_randomCGColor(alpha a: CGFloat = 1) -> CGColor {
        return self.randomColor(a).cgColor
    }
    
    static func demo_randomColor(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: alpha)
    }
    
    static func demo_rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.init(red: r / 255,
                            green: g / 255,
                            blue: b / 255,
                            alpha: 1.0)
    }
}
