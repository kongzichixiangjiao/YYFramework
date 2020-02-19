//
//  GACalenderScrollViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/28.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderScrollViewController: UIViewController {

    lazy var calenderScrollView: GACalenderScrollView = {
        let v = GACalenderScrollView(frame: CGRect(x: 0, y: 50, width: kScreenWidth, height: self.view.height))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        view.addSubview(calenderScrollView)
    }
    
}
