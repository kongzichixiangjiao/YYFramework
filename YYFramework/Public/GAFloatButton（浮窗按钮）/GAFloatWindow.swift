//
//  GAFloatWindow.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/29.
//  Copyright © 2019 houjianan. All rights reserved.
//  悬浮按钮

/*
DispatchQueue.main.fw_after(2.0) {
    GAFloatWindow.show {
        let vc = GAFloatWindowViewController(nibName: "GAFloatWindowViewController", bundle: nil)
        self.window?.rootViewController?.present(vc, animated: true, completion: nil)
    }
}
*/

import UIKit

enum GAFloatPositionType: Int {
    case right = 1, left = 2, none = 33
}

var floatWindow: GAFloatWindow?

class GAFloatWindow: UIWindow {
    
    static let bW: CGFloat = 50.0
    static let bH: CGFloat = 40.0
    static let bY: CGFloat = 240.0
    static var imgName: String = ""
    static var iconColor: UIColor = UIColor.white
    
    typealias GAFLoatHandler = () -> ()
    var handler: GAFLoatHandler!
    
    var postionType: GAFloatPositionType = .right
    
    lazy var imgView: UIImageView = {
        let v = UIImageView()
        v.frame = self.bounds
        v.contentMode = .scaleAspectFit
        let img = UIImage(named: GAFloatWindow.imgName)
        v.image = img?.fw_imageWithTintColor(tintColor: GAFloatWindow.iconColor, blendMode: CGBlendMode.screen)
        return v
    }()
    
    // MARK: init
    convenience init(frame: CGRect, type: GAFloatPositionType, handler: @escaping GAFLoatHandler) {
        self.init(frame: frame)
        
        self.postionType = type
        self.handler = handler
        
        self.addSubview(imgView)
    }
    
    // MARK: show
    static func initFloatWindow(imgName: String = "tabbar_icon04", iconColor: UIColor = UIColor.fw_randomColor(), windowLevel: CGFloat = 1000001.0, handler: @escaping GAFLoatHandler) {
        guard let currentWindow = UIApplication.shared.keyWindow else {
            return
        }
        if let _ = floatWindow {
            return
        }
        GAFloatWindow.imgName = imgName
        GAFloatWindow.iconColor = iconColor
        let frame = CGRect(x: UIScreen.main.bounds.width - bW, y: bY, width: bW, height: bH)
        floatWindow = GAFloatWindow(frame: frame, type: .right, handler: handler)
        floatWindow?.makeKeyAndVisible()
        floatWindow?.windowLevel = .init(windowLevel)
        floatWindow?.backgroundColor = UIColor.clear
        floatWindow?.isHidden = true
        currentWindow.makeKey()
    }
    
    static func show(handler: @escaping GAFLoatHandler) {
        initFloatWindow(handler: handler)
        floatWindow?.isHidden = false
    }
    
    static func hide() {
        floatWindow?.isHidden = true
    }
    
    var touchBtnX: CGFloat!
    var touchBtnY: CGFloat!
    var touchPoint: CGPoint!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        touchPoint = touch.location(in: self)
        touchBtnX = self.frame.origin.x
        touchBtnY = self.frame.origin.y
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        let currentPostion = touch.location(in: self)
        
        let offsetX = currentPostion.x - touchPoint.x
        let offsetY = currentPostion.y - touchPoint.y
        
        let centerX = self.center.x + offsetX
        var centerY = self.center.y + offsetY
        self.center = CGPoint(x: centerX, y: centerY)
        
        let superViewW = UIScreen.main.bounds.width
        let superViewH = UIScreen.main.bounds.height
        let btnX = self.frame.origin.x
        let btnY = self.frame.origin.y
        let btnW = self.frame.size.width
        let btnH = self.frame.size.height
        
        if btnX > superViewW {
            let centerX = superViewW - btnW / 2
            self.center = CGPoint(x: centerX, y: centerY)
        } else if btnX < 0 {
            let centerX = btnW * 0.5
            self.center = CGPoint(x: centerX, y: centerY)
        }
        
        let defaultNavH: CGFloat = 64.0
        let judgSupViewH = superViewH - defaultNavH
        
        if btnY <= 0 {
            centerY = btnH * 0.7
            self.center = CGPoint(x: centerX, y: centerY)
        } else if btnY > judgSupViewH {
            let y = superViewH - btnH * 0.5
            self.center = CGPoint(x: btnX, y: y)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let touch = touches.first else {
            return
        }
        
        touchPoint = touch.location(in: self)
        
        let btnY = self.frame.origin.y
        let btnX = self.frame.origin.x
        
        let minDistance: CGFloat = 2
        
        //结束move的时候，计算移动的距离是>最低要求，如果没有，就调用按钮点击事件
        let isOverX = abs(btnX - touchBtnX) > minDistance
        let isOverY = abs(btnY - touchBtnY) > minDistance
        
        if (isOverX || isOverY) {
            //超过移动范围就不响应点击 - 只做移动操作
            self.touchesCancelled(touches, with: event)
        } else {
            super.touchesEnded(touches, with: event)
            handler()
        }
        
        switch postionType {
        case .right:
            _right(y: btnY)
            break
        case .left:
            _left(y: btnY)
            break
        case .none:
            if self.center.x >= UIScreen.main.bounds.width / 2 {
                _right(y: btnY)
            } else {
                _left(y: btnY)
            }
            break
        }
    }
    
    private func _right(y: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            let bX = UIScreen.main.bounds.width - GAFloatWindow.bW
            self.frame = CGRect(x: bX, y: y, width: GAFloatWindow.bW, height: GAFloatWindow.bH)
        }
    }
    
    private func _left(y: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            let bX: CGFloat = 0.0
            self.frame = CGRect(x: bX, y: y, width: GAFloatWindow.bW, height: GAFloatWindow.bH)
        }
    }
    
}

extension DispatchQueue {
    func fw_after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}

extension UIColor {
    static func fw_randomCGColor(alpha a: CGFloat = 1) -> CGColor {
        return self.randomColor(a).cgColor
    }
    
    static func fw_randomColor(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: alpha)
    }
    
    static func fw_rgb(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat) -> UIColor {
        return UIColor.init(red: r / 255,
                            green: g / 255,
                            blue: b / 255,
                            alpha: 1.0)
    }
}

extension UIImage {
    func fw_imageWithTintColor(tintColor: UIColor, blendMode: CGBlendMode) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        tintColor.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        if blendMode != .destinationIn {
            self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        }
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
}
