//
//  GANormailizeADViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/19.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormailizeADViewController: GANormalizeBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        base_isShowNavigationView = false 
        // 网络请求
        // 配置网络请求的图片
        
        let v = YYNewPaperView(frame: self.view.bounds) { (type) in
            if type == .over {
                // 判断广告结束之后
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
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let tabVC = storyboard.instantiateViewController(withIdentifier: "YYTabBarViewController")
                    UIApplication.shared.keyWindow?.rootViewController = tabVC
                }
            } else {
                
            }
        }
        
        self.view.addSubview(v)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
