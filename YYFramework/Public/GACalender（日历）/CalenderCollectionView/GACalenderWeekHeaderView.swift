//
//  GACalenderWeekHeaderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/18.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderWeekHeaderView: UIView {
    static let height: CGFloat = 35
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _initViews() {
        let arr = ["日", "一", "二", "三", "四", "五", "六"]
        let stackView = UIStackView(frame: self.bounds)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        for i in 0..<arr.count {
            let text = arr[i]
            let v = UILabel()
            v.textAlignment = .center
            v.text = text
            stackView.addArrangedSubview(v)
        }
        
        self.addSubview(stackView)
    }
}
