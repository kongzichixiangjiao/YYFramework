//
//  GAAddIconViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/9.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAAddIconViewController: GANavViewController {
    
    @IBOutlet weak var vv: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "添加icon", isShow: true)

        let v = GADemoView()
        v.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        self.view.addSubview(v)
        v.ga_subViewAddIcon(named: "float_pop_icon")
        
        let v1 = GADemoView()
        v1.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        self.view.addSubview(v1)
        v1.ga_subViewAddIcon(named: "float_pop_icon", direction: .left, space: 10)
        
        let v2 = GADemoView()
        v2.frame = CGRect(x: 100, y: 350, width: 100, height: 100)
        self.view.addSubview(v2)
        v2.ga_subViewAddIcon(named: "float_pop_icon", direction: .top, space: 10)

        let v3 = GADemoView()
        v3.frame = CGRect(x: 100, y: 450, width: 100, height: 100)
        self.view.addSubview(v3)
        v3.ga_subViewAddIcon(named: "float_pop_icon", direction: .bottom, space: 10)
        
        
        vv.ga_addIcon(named: "float_pop_icon")
    }
    
}
