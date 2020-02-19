//
//  GANextWindow.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/29.
//  Copyright © 2019 houjianan. All rights reserved.
//

/*
let view = (self.tabBarController as! YYTabBarViewController).specialView

let bgView = UIImageView(frame: self.view.bounds)
bgView.image = UIImage(named: "next_bg")

let bgView = UIView(frame: self.view.bounds)
bgView.backgroundColor = UIColor.randomColor(1)

GANextWindow.show(bgView: bgView, targetView: view) {

}
*/

import UIKit

var nextWindow: GANextWindow!

class GANextWindow: UIWindow {
    
    typealias GAFinishedHandler = () -> ()
    var finished: GAFinishedHandler!
    
    // MARK: init
    convenience init(frame: CGRect, handler: @escaping GAFinishedHandler) {
        self.init(frame: frame)
    }
    
    // MARK: show
    static func show(bgView: UIView, targetView: UIView, offSetX: CGFloat = 0, offSetY: CGFloat = 0, handler: @escaping GAFinishedHandler) {
        guard let currentWindow = UIApplication.shared.keyWindow else {
            return
        }
        
        nextWindow = GANextWindow(frame: currentWindow.bounds, handler: handler)
        nextWindow.makeKeyAndVisible()
        nextWindow.windowLevel = .init(1000002)
        nextWindow.backgroundColor = UIColor.clear
        nextWindow.addSubview(bgView)
        
        let convertFrame = targetView.convert(targetView.bounds, to: currentWindow)
        let frame = CGRect(x: convertFrame.origin.x + offSetX, y: convertFrame.origin.y + offSetY, width: convertFrame.size.width, height: convertFrame.size.height)
        
        
        var path: UIBezierPath!
        if targetView.layer.cornerRadius == 0 {
            let x = convertFrame.origin.x
            let y = convertFrame.origin.y
            let w = convertFrame.size.width
            let h = convertFrame.size.height
            let bW = bgView.frame.size.width
            let bH = bgView.frame.size.height
            let bX = bgView.frame.origin.x
            let bY = bgView.frame.origin.y
        
            path = UIBezierPath.init()
            // 上
            path.move(to: CGPoint(x: bX, y: bY))
            path.addLine(to: CGPoint(x: bX + bW, y: bY))
            path.addLine(to: CGPoint(x: bX + bW, y: y))
            path.addLine(to: CGPoint(x: bX, y: y))
            path.addLine(to: CGPoint(x: bX, y: bY))
            // 下
            path.move(to: CGPoint(x: bX, y: y + h))
            path.addLine(to: CGPoint(x: bX + bW, y: y + h))
            path.addLine(to: CGPoint(x: bX + bW, y: bY + bH))
            path.addLine(to: CGPoint(x: bX, y: bY + bH))
            path.addLine(to: CGPoint(x: bX, y: y + h))
            // 左
            path.move(to: CGPoint(x: bX, y: y))
            path.addLine(to: CGPoint(x: bX, y: y + h))
            path.addLine(to: CGPoint(x: x, y: y + h))
            path.addLine(to: CGPoint(x: x, y: y))
            path.addLine(to: CGPoint(x: bX, y: y))
            // 右
            path.move(to: CGPoint(x: x + w, y: y))
            path.addLine(to: CGPoint(x: bX + bW, y: y))
            path.addLine(to: CGPoint(x: bX + bW, y: y + h))
            path.addLine(to: CGPoint(x: x + w, y: y + h))
            path.addLine(to: CGPoint(x: x + w, y: y))
            
            path.fill()
        } else {
            let x = ((convertFrame.origin.x + offSetX) + frame.width / 2)
            let y = ((convertFrame.origin.y + offSetY) + frame.height / 2)
            let point = CGPoint(x: x, y: y)
            path = UIBezierPath.init(roundedRect: bgView.frame, cornerRadius: 0)
            path.append(UIBezierPath.init(arcCenter: point, radius: targetView.layer.cornerRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false))
        }
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        
        bgView.layer.mask = shapeLayer
        
        currentWindow.makeKey()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.resignKey()
        self.isHidden = true
    }
}

extension DispatchQueue {
    func next_after(_ delay: TimeInterval, execute closure: @escaping () -> Void) {
        asyncAfter(deadline: .now() + delay, execute: closure)
    }
}
