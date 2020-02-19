//
//  GANormalize_JF_TabsStackViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/6/11.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GANormalize_JF_TabsStackViewController: GANormalizeTabsStackViewController {
    
    lazy var jfTabsLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.textColor = UIColor.gray
        v.textAlignment = .center
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let l1 = jfTabsLabel
        l1.text = "a1"
        let l2 = jfTabsLabel
        l2.text = "a2"
        let l3 = jfTabsLabel
        l3.text = "a3"
        let l4 = jfTabsLabel
        l4.text = "a4"
        
        tabsStackView.initItems(items: [l1, l2, l3, l4], lineView: nil)
    }
}

/*
 // 具体使用：
class GANormalizeTabsTestViewController: GANormalizeTabsStackViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = TabsTestViewController.init(nibName: "TabsTestViewController", bundle: nil)
        vc.view.backgroundColor = UIColor.randomColor()
        vc.l.text = "0"
        
        let vc1 = TabsTestViewController.init(nibName: "TabsTestViewController", bundle: nil)
        vc1.view.backgroundColor = UIColor.randomColor()
        vc1.l.text = "1"
        
        let vc2 = TabsTestViewController.init(nibName: "TabsTestViewController", bundle: nil)
        vc2.view.backgroundColor = UIColor.randomColor()
        vc2.l.text = "2"
        
        let vc3 = TabsTestViewController.init(nibName: "TabsTestViewController", bundle: nil)
        vc3.view.backgroundColor = UIColor.randomColor()
        vc3.l.text = "3"
        
        self.tabsStackView.initDefaultItems(titles: ["0", "1", "2", "3"], lineView: nil)
        self.tabsMainView.initVCS(vcs: [vc, vc1, vc2, vc3], headerView: self.tabsStackView)
        
        self.tabsMainView.frame = CGRect(x: 0, y: 44, width: self.tabsMainView.width, height: self.tabsMainView.height - 44)
    }
    
    override func ga_normalizeTabsMainViewCurrentVC(index: Int, vc: UIViewController) {
        print(index, vc)
    }
    
    override func ga_normalizeTabsMainViewDidScroll(didIndex: Int, index: Int) {
        print("didIndex = ", didIndex, "index = ", index)
    }
}
*/
