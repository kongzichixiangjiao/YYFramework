//
//  YYInterlockHeaderView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//  顶部视图和标题

import UIKit

class YYInterlockHeaderView: UIView {

    var titles: [String] = [] {
        didSet {
            if let t = topView {
                titlesView.frame = CGRect(x: 0, y: t.frame.size.height, width: self.frame.size.width, height: 60)
            } else {
                titlesView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 60)
            }
            self.addSubview(titlesView)
        }
    }
    var topView: UIView? {
        didSet {
            if let t = topView {
                self.addSubview(t)
            }
        }
    }
    
    lazy var titlesView: UIView = {
        let v = UIView(frame: CGRect.zero)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
