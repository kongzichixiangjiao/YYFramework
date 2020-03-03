//
//  GANavigationViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GANavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationBar.isHidden = true
        
    }
    
}

extension GANavigationViewController: UINavigationControllerDelegate {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}
