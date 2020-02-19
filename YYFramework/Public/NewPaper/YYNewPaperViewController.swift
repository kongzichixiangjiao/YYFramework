//
//  YYViewPaperViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/13.
//  Copyright © 2018年 houjianan. All rights reserved.
//  轮播 倒计时

import UIKit

class YYNewPaperViewController: UIViewController {

    var newPaperConfig: YYNewPaperConfig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = YYNewPaperView(frame: self.view.bounds, config: newPaperConfig!) { (type) in
            if type == .over {
                // 001、去首页
                // ...
//                UIApplication.shared.keyWindow?.rootViewController = tabbarVC
            } else if type == .login {
                // 001、去登陆界面
                // ...
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let tabbarVC = storyBoard.instantiateViewController(withIdentifier: "YYTabBarViewController")
                let loginVC = YYLoginViewController(nibName: "YYLoginViewController", bundle: nil)
                loginVC.backWay = .root(vc: tabbarVC)
                UIApplication.shared.keyWindow?.rootViewController = loginVC
            } else {
                
            }
        }
  
        self.view.addSubview(v)
        
        // gif
//        let filePath = Bundle.main.path(forResource: "guideImage6.gif", ofType: nil) ?? ""
//        let url = URL(fileURLWithPath: filePath)
//        let data = try? Data(contentsOf: url, options: Data.ReadingOptions.uncached)
//        let type = GAImageType.checkDataType(data: data)
//        if type == .gif {
//            let gifV = YYGIFImage(frame: self.view.bounds, gifData: data!)
//            self.view.addSubview(gifV)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("deinit YYNewPaperViewController")
    }

}

