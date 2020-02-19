//
//  GAAnimationWindow.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/31.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

enum GAAnimationType: Int {
    case none = 99, `default` = 0, alert = 1, sheet = 2
}

enum GAAnimationDirectionType: Int {
    case right = 0, left = 1, bottom = 2, top = 3, middle = 4
}

class GAAnimationWindow: UIWindow {
    
    static let share: GAAnimationWindow = GAAnimationWindow(frame: UIScreen.main.bounds)
    typealias GAAnimationWindowHandler = () -> ()
    var handler: GAAnimationWindowHandler?
    
    var targetView: UIView!
    var targetViewFrame: CGRect!
    var direction: GAAnimationDirectionType!
    var usingSpringWithDamping: CGFloat = 0.3
    var initialSpringVelocity: CGFloat = 0.6
    
    func show(v: UIView, type: GAAnimationType = .alert, direction: GAAnimationDirectionType = .right, handler: GAAnimationWindowHandler?) {
        
        self.handler = handler
        self.direction = direction
        self.targetView = v
        self.targetViewFrame = v.frame
        
        self.addSubview(v)
        
        guard let currentWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        self.makeKeyAndVisible()
        self.windowLevel = .init(1000004.0)
        self.backgroundColor = "000000".color0X(0.1)
        
        currentWindow.makeKey()
        
        _animation(type: type)
    }
    
    private func _animation(type: GAAnimationType) {
        _initFrame()

        let w: CGFloat = self.targetViewFrame.size.width
        let h: CGFloat = self.targetViewFrame.size.height
        let screenW: CGFloat = UIScreen.main.bounds.width
        let screenH: CGFloat = UIScreen.main.bounds.height
        
        switch type {
        case .default:
            UIView.animate(withDuration: 0.3) {
                self.targetView.frame = CGRect(x: screenW - w, y: screenH / 2 - h / 2, width: w, height: h)
            }
            break
        case .alert:
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.targetView.frame = CGRect(x: screenW / 2 - w / 2, y: screenH / 2 - h / 2, width: w, height: h)
            }) { (finished) in
                
            }
            break
        case .sheet:
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: UIView.AnimationOptions.curveEaseIn, animations: {
                if self.direction == .left {
                    self.targetView.frame = CGRect(x: 0, y: screenH / 2 - h / 2, width: w, height: h)
                } else if self.direction == .right {
                    self.targetView.frame = CGRect(x: screenW - w, y: screenH / 2 - h / 2, width: w, height: h)
                } else if self.direction == .bottom {
                    self.targetView.frame = CGRect(x: screenW / 2 - w / 2, y: screenH - h, width: w, height: h)
                } else if self.direction == .top {
                    self.targetView.frame = CGRect(x: screenW / 2 - w / 2, y: 0, width: w, height: h)
                } else {
                    
                }
            }) { (finished) in
                
            }
            break
        case .none:
            break
        }
    }
    
    private func _animationAlert(direction: GAAnimationDirectionType) {
        
    }
    
    private func _initFrame() {
        let w: CGFloat = targetView.frame.size.width
        let h: CGFloat = targetView.frame.size.height
        let screenW: CGFloat = UIScreen.main.bounds.width
        let screenH: CGFloat = UIScreen.main.bounds.height
        
        switch direction {
        case .right:
            targetView.frame = CGRect(x: w, y: screenH / 2 - h / 2, width: w, height: h)
            break
        case .left:
            targetView.frame = CGRect(x: -w, y: screenH / 2 - h / 2, width: w, height: h)
            break
        case .bottom:
            targetView.frame = CGRect(x: screenW / 2 - w / 2, y: screenH, width: w, height: h)
            break
        case .top:
            targetView.frame = CGRect(x: screenW / 2 - w / 2, y: -h, width: w, height: h)
            break
        case .middle:
            targetView.frame = CGRect(x: screenW / 2 - w / 2, y: screenH / 2 - h / 2, width: 2, height: 2)
            targetView.center = self.center
            break
        case .none:
            break 
        }
    }
    
    private func _animationHide() {
        let w: CGFloat = targetView.frame.size.width
        let h: CGFloat = targetView.frame.size.height
        let screenW: CGFloat = UIScreen.main.bounds.width
        let screenH: CGFloat = UIScreen.main.bounds.height
        var endFrame: CGRect?
        
        switch direction {
        case .right:
            endFrame = CGRect(x: w, y: screenH / 2 - h / 2, width: w, height: h)
            break
        case .left:
            endFrame = CGRect(x: -w, y: screenH / 2 - h / 2, width: w, height: h)
            break
        case .bottom:
            endFrame = CGRect(x: screenW / 2 - w / 2, y: screenH, width: w, height: h)
            break
        case .top:
            endFrame = CGRect(x: screenW / 2 - w / 2, y: -h, width: w, height: h)
            break
        case .middle:
            endFrame = CGRect(x: screenW / 2 - w / 2, y: screenH / 2 - h / 2, width: w, height: h)
            break
        case .none:
            break
        }
        
        guard let frame = endFrame else {
            self.targetView.frame = CGRect.zero
            self.hide()
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.targetView.frame = frame
            if self.direction == .middle {
                self.targetView.center = self.center
            }
        }) { (finished) in
            if finished {
                self.hide()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.handler?()
        
        _animationHide()
        
    }
    
    func hide() {
        targetView.frame = self.targetViewFrame
        targetView.removeFromSuperview()
        
        self.resignKey()
        self.isHidden = true
    }
}
