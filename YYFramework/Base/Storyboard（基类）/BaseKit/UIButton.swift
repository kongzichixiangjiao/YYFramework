//
//  UIButton.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

class Button: UIButton {
    
    @IBInspectable var disableHighlighted: Bool = false
    
    override var isHighlighted: Bool {
        set {
            if !disableHighlighted {
                super.isHighlighted = newValue
            }
        }
        
        get {
            return super.isHighlighted
        }
    }
    
    @IBInspectable var normalBgColor: UIColor {
        set {
            self.setBackgroundImage(UIImage.image(withColor: newValue), for: .normal)
        }
        
        get {
            return .white
        }
    }
    
    @IBInspectable var highlightedBgColor: UIColor {
        set {
            self.setBackgroundImage(UIImage.image(withColor: newValue), for: .highlighted)
        }
        
        get {
            return .white
        }
    }
    
    @IBInspectable var selectedBgColor: UIColor {
        set {
            self.setBackgroundImage(UIImage.image(withColor: newValue), for: .selected)
        }
        
        get {
            return .white
        }
    }
    
    @IBInspectable var disabledBgColor: UIColor {
        set {
            self.setBackgroundImage(UIImage.image(withColor: newValue), for: .disabled)
        }
        
        get {
            return .white
        }
    }
}

class FeedbackButton: Button {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.highlightedBgColor = 0xe0e0e0.color
    }
    
}
