//
//  GAFormHeaderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GAFormHeaderViewDelegate: class {
    func ga_formHeaderViewClicked(section: Int)
}

class GAFormHeaderView: UIView {
    
    var delegate: GAFormHeaderViewDelegate?
    
    var section: Int = -1
    
    var configModel: GAFormConfigModel!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if section != -1 {
            delegate?.ga_formHeaderViewClicked(section: section)
        }
    }
    
    var items: [GAFormRowModel]?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        while (self.subviews.count != 0) {
            self.subviews.last?.removeFromSuperview()
        }
        guard let items = self.items else {
            return
        }
        
        for (i, item) in items.enumerated() {
            let w: CGFloat = self.configModel.rItemWidth
            let x: CGFloat = CGFloat(i) * w
            let y: CGFloat = 0
            let h: CGFloat = self.configModel.itemHeaderHeight
            let l = GAStrokeLabel(frame: CGRect(x: x, y: y, width: w, height: h))
            l.strokeColor = UIColor.brown
            l.font = UIFont.boldSystemFont(ofSize: 10)
            l.textAlignment = .center
            l.text = item.title
            self.addSubview(l)
        }
    }
}
