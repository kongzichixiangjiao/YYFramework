//
//  YYInterlockViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class YYInterlockViewController: YYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vc1 = YYInterlockItemViewController()
        vc1.setup()
        let vc2 = YYInterlockItemViewController()
        vc2.setup()
        let vc3 = YYInterlockItemViewController()
        vc3.setup()
        
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: 230))
        topView.backgroundColor = UIColor.randomColor()
        
        let vcs = [vc1, vc2, vc3]
//        let v = YYInterlockView(frame: self.view.bounds, vcs: vcs)
        let v = YYInterlockView(frame: self.view.bounds, vcs: vcs, pageTitles: ["霸天虎", "孙悟空", "小二哈"], topView: topView)
//        let v = YYXibInterlockView.loadXibInterlockView()
//        v.configUI(headerView: nil, vcs: vcs)
        self.view.addSubview(v)
        
    }

}
