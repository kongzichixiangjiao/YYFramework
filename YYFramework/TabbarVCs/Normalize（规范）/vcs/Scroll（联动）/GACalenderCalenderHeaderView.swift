//
//  GACalenderCalenderHeaderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GACalenderCalenderHeaderViewDelegate: class {
    func selectedDateCalenderView_updateViewsFrame(h: CGFloat)
}

extension GACalenderCalenderHeaderView: GASelectedDateCalenderViewDelegate {
    func selectedDateCalenderView_updateViewsFrame(h: CGFloat) {
        delegate?.selectedDateCalenderView_updateViewsFrame(h: h)
    }
}

class GACalenderCalenderHeaderView: UICollectionReusableView {

    weak var delegate: GASelectedDateCalenderViewDelegate?
    
    lazy var calenderView: GASelectedDateCalenderView = {
        let v = GASelectedDateCalenderView(frame: CGRect(x: 0, y: 100, width: self.width, height: self.height / 2))
        v.delegate = self 
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(calenderView)
    }
    
}
