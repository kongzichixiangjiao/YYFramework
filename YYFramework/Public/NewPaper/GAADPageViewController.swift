//
//  GAADPageViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/25.
//  Copyright © 2019年 houjianan. All rights reserved.
//  广告页

import UIKit

class GAADPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = YYNewPaperView(frame: self.view.bounds) { (type) in
            if type == .over {
                if true {
                    // 新特性轮播图界面
                    let vc = YYNewPaperViewController()
                    let config = YYNewPaperConfig()
                    config.isShowTimer = false
                    config.dataSource = ["img_001.jpg", "img_002.jpg", "img_003.jpg"]
                    config.isShowLastButton = true 
                    vc.newPaperConfig = config
                    UIApplication.shared.keyWindow?.rootViewController = vc
                } else {
                    // 去首页 或者登录页
                }
            } else {
                
            }
        }

        self.view.addSubview(v)
    }


}
