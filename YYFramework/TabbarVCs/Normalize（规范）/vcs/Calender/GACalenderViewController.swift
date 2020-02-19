//
//  GACalenderViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/16.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderViewController: UIViewController {

    lazy var calenderView: GACalenderView = {
        let v = GACalenderView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: self.view.height / 2))
        return v
    }()
    
    lazy var calenderScrollView: GACalenderScrollView = {
        let v = GACalenderScrollView(frame: CGRect(x: 0, y: self.view.height / 2, width: kScreenWidth, height: self.view.height / 2))
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calenderView.backgroundColor = UIColor.lightGray
        view.addSubview(calenderView)
        
        view.addSubview(calenderScrollView)
    }

}

