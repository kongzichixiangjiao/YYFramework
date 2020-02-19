//
//  GALoginViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/8.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GALoginViewController: GANavViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        b_showNavigationView(title: "登录/退出")
    }

    @IBAction func login(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyBoard.instantiateViewController(withIdentifier: "YYTabBarViewController")
        let loginVC = YYLoginViewController(nibName: "YYLoginViewController", bundle: nil)
        loginVC.backWay = .root(vc: tabbarVC)
        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }
   
    @IBAction func logout(_ sender: Any) {
        KeychainItem.deleteUserIdentifierFromKeychain()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyBoard.instantiateViewController(withIdentifier: "YYTabBarViewController")
        let loginVC = YYLoginViewController(nibName: "YYLoginViewController", bundle: nil)
        loginVC.backWay = .root(vc: tabbarVC)
        UIApplication.shared.keyWindow?.rootViewController = loginVC
    }
    
}
