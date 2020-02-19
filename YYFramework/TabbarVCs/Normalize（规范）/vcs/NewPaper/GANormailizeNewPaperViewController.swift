//
//  GANormailizeNewPaperViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/19.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormailizeNewPaperViewController: GANormalizeBaseViewController {

    var newPaperConfig: YYNewPaperConfig?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        base_isShowNavigationView = false
        
        // config
        let config = YYNewPaperConfig()
        config.isShowTimer = false
        config.dataSource = ["img_001.jpg", "img_002.jpg", "img_003.jpg"]
        config.isShowLastButton = true
        newPaperConfig = config
        
        let v = YYNewPaperView(frame: self.view.bounds, config: newPaperConfig!) { (type) in
            if type == .over {
                // 001、去首页
                // ...
                //                UIApplication.shared.keyWindow?.rootViewController = tabbarVC
                
                // test
                self.navigationController?.popViewController(animated: true)
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
        print("deinit GANormailizeNewPaperViewController")
    }

}
