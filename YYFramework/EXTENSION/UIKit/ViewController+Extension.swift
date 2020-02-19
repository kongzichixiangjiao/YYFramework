//
//  ViewController+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/8.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

/*
 *  交换方法viewWillAppear、viewDidDisappear方法
 *  获取storyboard的root vc
 *  push pop present相关犯法
 */

import UIKit

extension UIViewController {
    func ga_storyboardRootVC(name: String) -> UIViewController? {
        if name.isEmpty {
            print("error ga_storyboardRootVC name字符串为空")
            return nil
        }
        guard let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else {
            print("error ga_storyboardRootVC 没有viewcontroller")
            return nil
        }
        return vc
    }
}

// MARK: - Push Pop 方法
extension UIViewController {
    /// PUSH
    func yy_push(vc: UIViewController, animated: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        nv.pushViewController(vc, animated: animated)
    }
    /// PUSH XIB 只能展示VC view
    func yy_pushXIB(nibName: String, animated: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        let vc = UIViewController(nibName: nibName, bundle: nil)
        nv.pushViewController(vc, animated: animated)
    }
    
    /// POP
    func yy_pop(animated: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        nv.popViewController(animated: animated)
    }
    /// POPTO
    func yy_popTo(vc: UIViewController, animted: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        for item in nv.viewControllers {
            if item == vc {
                nv.popToViewController(vc, animated: true)
                return
            }
        }
        print("没有目标UIViewController")
    }
    /// POPROOT
    func yy_popRoot(animated: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        nv.popToRootViewController(animated: true);
        
    }
    /// PRESENT
    func yy_present(animated: Bool = true) {
        present(self, animated: animated, completion: nil)
    }
    // storyboar PUSH
    func yy_push(storyboardName name: String, animated: Bool = true) {
        if name.isEmpty {
            print("name字符串为空")
            return
        }
        guard let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else {
            print("没有viewcontroller")
            return
        }
        yy_push(vc: vc, animated: animated)
    }
    // storyboar PUSH
    func yy_push(storyboardName name: String, vcIdentifier identifier: String, animated: Bool = true) {
        if name.isEmpty || identifier.isEmpty {
            print("字符串有空")
            return
        }
        let vc = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
        yy_push(vc: vc, animated: animated)
    }
    
}

extension UIViewController {
    
    func ga_resentVC(vc: UIViewController) -> UIViewController? {
        guard let p = vc.presentedViewController else {
            return self
        }
        return ga_resentVC(vc: p)
    }
    
}


extension UIViewController {
    // mandatoryLandscape: true横屏 false竖屏
    func ga_showScreenDirection(mandatoryLandscape: Bool) {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.vc_mandatoryLandscape = mandatoryLandscape
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }
}

var vc_viewController_key: UInt = 191211
extension AppDelegate {
    
    var vc_mandatoryLandscape: Bool? {
        get {
            return objc_getAssociatedObject(self, &vc_viewController_key) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &vc_viewController_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
        // 项目实现这个方法
//    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
//        if vc_mandatoryLandscape ?? false {
//            return .landscapeLeft //强制横屏时这里可保持一个方向
//        }
//        return .portrait
//    }
    
}

// plist View controller-based status bar appearance   YES
extension UIAlertController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    open override var shouldAutorotate: Bool {
        return false
    }
}
