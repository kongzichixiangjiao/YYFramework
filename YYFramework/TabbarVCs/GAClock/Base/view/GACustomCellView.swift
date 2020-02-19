//
//  GACustomeCell.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/26.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACustomCellView: UIView {

    @IBInspectable var normalColor: UIColor = .white
    @IBInspectable var selectedColor: UIColor = 0xe0e0e0.color
    
    var didClick: (()->Void)?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = selectedColor
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = normalColor
        if let block = self.didClick {
            block()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.backgroundColor = normalColor
    }

}

