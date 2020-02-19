//
//  UIViewController.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

extension UIViewController {
    private class func from<T: UIViewController>(storyboard board: UIStoryboard, type: T.Type) -> T {
        return board.instantiateViewController(withIdentifier: String(describing: type)) as! T
    }
    
    class func from(storyboard name: String) -> Self {
        return from(storyboard: UIStoryboard(name: name, bundle: nil), type: self)
    }
    
    class func from(storyboard board: UIStoryboard) -> Self {
        return from(storyboard: board, type: self)
    }
}

extension UIViewController {
    weak var preViewController: UIViewController? {
        let index = self.navigationController?.viewControllers.firstIndex(of: self)
        if let index = index, index > 0 {
            return self.navigationController?.viewControllers[index-1]
        }
        return nil
    }
}

extension UIViewController {
    
    class func top() -> UIViewController? {
        if let vc = UIApplication.shared.delegate?.window??.rootViewController {
            if let tab = vc as? UITabBarController {
                if let nav = tab.selectedViewController as? UINavigationController {
                    return nav.topViewController
                }
            } else if let nav = vc as? UINavigationController {
                return nav.topViewController
            } else {
                return vc
            }
        }
        return nil
    }
    
    class func topNavigationController() -> UINavigationController? {
        if let vc = UIApplication.shared.delegate?.window??.rootViewController {
            if let tab = vc as? UITabBarController {
                if let nav = tab.selectedViewController as? UINavigationController {
                    return nav
                }
            } else if let nav = vc as? UINavigationController {
                return nav
            } else {
                return nil
            }
        }
        return nil
    }
}
