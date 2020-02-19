//
//  GA_UIViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/5.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GA_UIViewController: YYBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func vantUI(_ sender: UIButton) {
        let tag = sender.tag
        let vcs = [GA_VantUIViewController(), GATestViewController(), GATestNexttViewController(), XCTabBarViewController()]
        let vc = vcs[tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
