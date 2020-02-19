//
//  GAFormTopTitleView.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAFormTopTitleView: UIView {
    
    var configModel: GAFormConfigModel! {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
    }
    
    lazy var contentView: UIView = {
        let v = UIView()
        return v
    }()
    
    func initItemsView(items: [String]) {
        while (self.subviews.count != 0) {
            self.subviews.last?.removeFromSuperview()
        }
        
        for (i, s) in items.enumerated() {
            let w: CGFloat = self.configModel.rItemWidth
            let x: CGFloat = CGFloat(i) * w
            let y: CGFloat = 0
            let h: CGFloat = self.configModel.topViewHeight
            let l = GAStrokeLabel(frame: CGRect(x: x, y: y, width: w, height: h))
            l.font = UIFont.systemFont(ofSize: 10)
            l.text = s
            self.addSubview(l)
        }
    }
        
}
