//
//  GAButtonViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/23.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
//import BaiduMobStat

class GAButtonViewController: GANormalizeBaseViewController {
    
    @IBOutlet weak var b2: GAIconButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        b2.addEndAction {
            [unowned self] ouchState, state in
            self.b2.ga_changeIsSelected(!self.b2.isSelected)
        }
    }
    
    deinit {
        print("deinit GAButtonViewController")
    }
}

