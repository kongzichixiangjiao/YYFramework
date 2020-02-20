//
//  GAself.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/15.
//  Copyright © 2019 houjianan. All rights reserved.
//  视频全屏


/*
 if button.isSelected {
 GAPlayerWindow.share.exitFullScreen(subView: self.view)
 self.view.addSubview(bgPlayerView)
 for layout in bgPlayerView.constraints {
 if (layout.firstItem as? NSObject == bgPlayerView && layout.firstAttribute == NSLayoutConstraint.Attribute.height) {
 layout.constant = 300
 }
 if (layout.firstItem as? NSObject == bgPlayerView && layout.firstAttribute == NSLayoutConstraint.Attribute.width) {
 layout.constant = kScreenWidth - 20
 }
 }
 view.addConstraint(NSLayoutConstraint(item: bgPlayerView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
 view.addConstraint(NSLayoutConstraint(item: bgPlayerView!, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
 } else {
 GAPlayerWindow.share.enterFullScreen(v: bgPlayerView, isXIB: true)
 }
 */
import UIKit

class GAPlayerWindowViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
    }
    
}

class GAPlayerWindow: UIWindow {
    
    static let share: GAPlayerWindow = GAPlayerWindow(frame: UIScreen.main.bounds)
    
    var targetView: UIView!
    var smallPreViewFrame: CGRect!
    
    // 进入全屏模式
    func enterFullScreen(v: UIView, isXIB: Bool = false) {
        targetView = v
        
        guard let currentWindow = UIApplication.shared.keyWindow else {
            return
        }
        self.smallPreViewFrame = v.frame
        
        let rectInWindow = v.convert(v.bounds, to: UIApplication.shared.keyWindow)
        v.removeFromSuperview()
        v.frame = rectInWindow
        
        let vc = GAPlayerWindowViewController()
        
        self.makeKeyAndVisible()
        self.windowLevel = .alert + 3
        self.backgroundColor = UIColor.clear 
        self.rootViewController = vc
        
        if isXIB {
            
            for layout in v.constraints {
                if layout.firstItem as? NSObject == v {
                    v.removeConstraint(layout)
                }
            }
            vc.view.isUserInteractionEnabled = true 
            vc.view.addSubview(v)
            
            vc.view.addConstraint(NSLayoutConstraint(item: v, attribute: .centerX, relatedBy: .equal, toItem: vc.view, attribute: .centerX, multiplier: 1, constant: 0))
            vc.view.addConstraint(NSLayoutConstraint(item: v, attribute: .centerY, relatedBy: .equal, toItem: vc.view, attribute: .centerY, multiplier: 1, constant: 0))
            v.addConstraint(NSLayoutConstraint(item: v, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: max(kScreenWidth, kScreenHeight)))
            v.addConstraint(NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: min(kScreenWidth, kScreenHeight)))
            
            UIView.animate(withDuration: 0.5, animations: {
                v.layoutIfNeeded()
                v.transform = v.transform.rotated(by: .pi / 2)
            }) { (isFinished) in
                
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                v.transform = v.transform.rotated(by: .pi / 2)
                v.bounds = CGRect(x: 0, y: 0, width: max(kScreenWidth, kScreenHeight), height: min(kScreenWidth, kScreenHeight))
                v.center = CGPoint(x: v.superview!.bounds.midX, y: v.superview!.bounds.midY)
            }) { (isFinished) in
                
            }
        }
        
        currentWindow.makeKey()
    }
    
    
    // 退出全屏
    func exitFullScreen(subView: UIView, isXIB: Bool = false) {
        if isXIB {
            subView.addSubview(targetView)
            
            for layout in targetView.constraints {
                if layout.firstItem as? NSObject == targetView {
                    targetView.removeConstraint(layout)
                }
            }
            subView.addSubview(targetView)
            
            subView.addConstraint(NSLayoutConstraint(item: targetView!, attribute: .centerX, relatedBy: .equal, toItem: subView, attribute: .centerX, multiplier: 1, constant: 0))
            subView.addConstraint(NSLayoutConstraint(item: targetView!, attribute: .centerY, relatedBy: .equal, toItem: subView, attribute: .centerY, multiplier: 1, constant: 0))
            targetView.addConstraint(NSLayoutConstraint(item: targetView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: min(kScreenWidth, kScreenHeight)))
            targetView.addConstraint(NSLayoutConstraint(item: targetView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: min(kScreenWidth, kScreenHeight) * 9 / 16))
            UIView.animate(withDuration: 0.5, animations: {
                self.targetView.transform = CGAffineTransform.identity
            }) { (isFinished) in
            }
        } else {
            let frame = subView.convert(self.smallPreViewFrame, to: self)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.targetView.transform = CGAffineTransform.identity
                self.targetView.frame = frame
            }) { (isFinished) in
            }
        }
        self.resignKey()
        self.isHidden = true
    }
    
}
