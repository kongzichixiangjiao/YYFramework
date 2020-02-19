//
//  UIApplication+Extension.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

extension UIApplication {
    
    class func ga_currentVC(_ baseViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationViewController = baseViewController as? UINavigationController {
            return ga_currentVC(navigationViewController.visibleViewController)
        }
        
        if let tab = baseViewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return ga_currentVC(selected)
            }
        }
        
        if let presented = baseViewController?.presentedViewController {
            return ga_currentVC(presented)
        }
        
        return baseViewController
    }
    
}
