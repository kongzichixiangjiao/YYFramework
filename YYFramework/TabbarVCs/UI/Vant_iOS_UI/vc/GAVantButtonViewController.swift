//
//  GAVantButtonViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/3/18.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GAVantButtonViewController: GANavViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        _request()
    }
    
    private func _initViews() {
        b_showNavigationView(title: "按钮集合")
    }
    
    private func _request() {
        
    }
}
