//
//  GACalenderControlHeaderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/18.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GACalenderControlHeaderViewDelegate: class {
    func calenderControlHeaderView_left()
    func calenderControlHeaderView_right()
    func calenderControlHeaderView_title()
}

class GACalenderControlHeaderView: UIView {
    
    static let height: CGFloat = 35
    
    weak var delegate: GACalenderControlHeaderViewDelegate?
    
    var middleText: String! {
        didSet {
            middleButton.setTitle(middleText, for: .normal)
        }
    }
    
    lazy var rightButton: UIButton = {
        let v = UIButton(type: .custom)
        v.frame = CGRect(x: self.frame.width * 2 / 3, y: 0, width: self.frame.width / 3, height: self.frame.height)
        v.tag = 201903
        v.addTarget(self, action:  #selector(clickedAction(sender:)), for: .touchUpInside)
        v.setTitle("下一月", for: .normal)
        return v
    }()
    
    lazy var middleButton: UIButton = {
        let v = UIButton(type: .custom)
        v.frame = CGRect(x: self.frame.width / 3, y: 0, width: self.frame.width / 3, height: self.frame.height)
        v.addTarget(self, action:  #selector(clickedAction(sender:)), for: .touchUpInside)
        v.tag = 201902
        v.setTitle("2019-12-12", for: .normal)
        return v
    }()
    
    lazy var leftButton: UIButton = {
        let v = UIButton(type: .custom)
        v.frame = CGRect(x: 0, y: 0, width: self.frame.width / 3, height: self.frame.height)
        v.tag = 201901
        v.addTarget(self, action:  #selector(clickedAction(sender:)), for: .touchUpInside)
        v.setTitle("上一月", for: .normal)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _initViews() {
        self.addSubview(leftButton)
        self.addSubview(middleButton)
        self.addSubview(rightButton)
    }
    
    @objc func clickedAction(sender: UIButton) {
        let tag = sender.tag
        if tag == 201901 {
            delegate?.calenderControlHeaderView_left()
        } else if tag == 201902 {
            delegate?.calenderControlHeaderView_title()
        } else if tag == 201903 {
            delegate?.calenderControlHeaderView_right()
        } else {
            
        }
    }
    
}
