//
//  GAFullScreenPlayerViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/11.
//  Copyright © 2019 houjianan. All rights reserved.
//

/*
 if state == .full {
 let vc = GAFullScreenPlayerViewController()
 vc.targetView = player
 self.present(vc, animated: true, completion: nil)
 } else {
 self.dismiss(animated: false) {
 self.px_banner.reloadCellView()
 }
 }
 */
import UIKit

class GAFullScreenPlayerViewController: GANavViewController {
    
    private let kOrientation: String = "orientation"
    
    var targetView: UIView!
    var isXib: Bool = false
    
    private var currentType: UIInterfaceOrientation?
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(targetView)
        if isXib {
            self.view.addConstraint(NSLayoutConstraint(item: targetView!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: targetView!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: targetView!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: targetView!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        } else {
            targetView.frame = self.view.bounds
        }
        
        addDeviceOrientationNotification()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    // 运行页面随设备转动
    override var shouldAutorotate : Bool {
        return false 
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    private func addDeviceOrientationNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillChangeStatusBarOrientationNotification(sender:)),
                                               name: UIApplication.willChangeStatusBarOrientationNotification,
                                               object: nil)
    }
    
    private func removeDeviceOrientationNotification() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
    }
    
    @objc func applicationWillChangeStatusBarOrientationNotification(sender: Notification) {
        let type = UIInterfaceOrientation(rawValue: sender.userInfo?[UIApplication.statusBarOrientationUserInfoKey] as! Int)
        if currentType == type {
            return
        }
        applicationWillChangeStatusBarOrientation(type: type!)
        currentType = type
    }
    
    private func applicationWillChangeStatusBarOrientation(type: UIInterfaceOrientation) {
        switch type {
        case .landscapeLeft:
            break
        case .landscapeRight:
            break
        case .portrait:
            break
        case .portraitUpsideDown:
            break
        case .unknown:
            break
        @unknown default:
            break
        }
    }
    
    deinit {
        removeDeviceOrientationNotification()
    }
}
