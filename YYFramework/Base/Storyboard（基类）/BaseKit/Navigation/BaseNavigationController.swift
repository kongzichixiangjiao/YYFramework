//
//  BaseNavigationViewController.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

extension UIViewController {
    var canUseGestureToBack: Bool {
        return true
    }
}

class BaseNavigationController: UINavigationController, UIGestureRecognizerDelegate {

    var backPan: UIScreenEdgePanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let internalTargets = self.interactivePopGestureRecognizer?.value(forKey: "targets") as! Array<AnyObject>
        let target = internalTargets.first?.value(forKey: "target")
        
        self.backPan = UIScreenEdgePanGestureRecognizer.init(target: target, action: NSSelectorFromString("handleNavigationTransition:"))
        self.backPan.edges = .left
        self.backPan.delegate = self
        
        self.view.addGestureRecognizer(self.backPan)

        self.isNavigationBarHidden = true
//        self.isNavigationBarHidden = false
        self.navigationBar.isHidden = true
        
    }
    
     func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
         let canBack = self.topViewController?.canUseGestureToBack ?? false
         return self.viewControllers.count > 1 && canBack
     }
     
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: - 屏幕旋转控制
    override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return topViewController?.preferredInterfaceOrientationForPresentation ?? super.preferredInterfaceOrientationForPresentation
    }
    
    // MARK: - Status bar
    override var prefersStatusBarHidden: Bool {
        return topViewController?.prefersStatusBarHidden ?? super.prefersStatusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return topViewController?.preferredStatusBarUpdateAnimation ?? super.preferredStatusBarUpdateAnimation
    }
    
    deinit {
        DLog("deinit \(self.classForCoder)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
