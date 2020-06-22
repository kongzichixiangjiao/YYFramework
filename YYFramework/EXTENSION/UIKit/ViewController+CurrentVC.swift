//
//  ViewController+CurrentVC.swift
//  YYFramework
//
//  Created by houjianan on 2020/3/3.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

extension UIViewController {
    
    /** 获取当前控制器 */
    static func ga_currentVC() -> UIViewController? {
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        return UIViewController.findBest(vc: vc)
    }
    
    private static func findBest(vc: UIViewController) -> UIViewController {
        if vc.presentedViewController != nil {
            return UIViewController.findBest(vc: vc.presentedViewController!)
        } else if vc.isKind(of: UISplitViewController.self) {
            let svc = vc as! UISplitViewController
            if svc.viewControllers.count > 0 {
                return UIViewController.findBest(vc: svc.viewControllers.last!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UINavigationController.self) {
            let svc = vc as! UINavigationController
            if svc.viewControllers.count > 0 {
                return UIViewController.findBest(vc: svc.topViewController!)
            } else {
                return vc
            }
        } else if vc.isKind(of: UITabBarController.self) {
            let svc = vc as! UITabBarController
            if (svc.viewControllers?.count ?? 0) > 0 {
                if let vc = svc.selectedViewController {
                    return UIViewController.findBest(vc: vc)
                }
            } else {
                return vc
            }
        } else {
            return vc
        }
        return vc 
    }
}
