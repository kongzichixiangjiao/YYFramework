//
//  YYInterlockRootViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//  闹表入口

import UIKit

class GAAppRootViewController: YYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clock(_ sender: Any) {
        let vc = "GAClock".yy_storyboard().instantiateInitialViewController()
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

