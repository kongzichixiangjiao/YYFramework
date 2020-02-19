//
//  GANormalizeTabsStackViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/6/11.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GANormalizeTabsStackViewController: GANormalizeTabsBaseViewController {
    lazy var tabsStackView: GANormalizeTabsStackView = {
        let v = GANormalizeTabsStackView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44), isShowLineView: false)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func initItems(items: [UIView], lineView: UIView?) {
        self.tabsStackView.initItems(items: items, lineView: lineView)
    }
    
    public func initDefaultItems(titles: [String], lineView: UIView?) {
        self.tabsStackView.initDefaultItems(titles: ["0", "1", "2", "3"], lineView: nil)
    }
}
