//
//  GAFormViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/20.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAFormViewController: GANavViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "表格")
        
        let v = GAFormView(frame: CGRect(x: 20, y: 100, width: self.view.width - 40, height: 400))
        self.view.addSubview(v)
    }
}
