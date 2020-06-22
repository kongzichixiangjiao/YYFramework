//
//  GABanner+Extension.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

// 写一个Timer的分类。
extension Timer {
    class func banner_scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
        }
        return scheduledTimer(timeInterval: interval, target: self, selector: #selector(ga_handerTimerAction), userInfo: GABannerBlock(block), repeats: true)
    }
    
    // 一定要加class。 Timer是类对象，只能调用类方法，不能调用实例方法（否则报错：[NSTimer xx_handerTimerAction:]: unrecognized selector sent to class 0x1105c30c0'）
    @objc class func banner_handerTimerAction(_ sender: Timer) {
        if let block = sender.userInfo as? GABannerBlock<(Timer) -> Void> {
            block.type(sender)
        }
    }
}

//Block模型类
class GABannerBlock<T> {
    let type: T
    init(_ type: T) {
        self.type = type
    }
}


// MARK: view是否在window上
extension UIView {
    
    func banner_isShowingOnWindow() -> Bool {
        
        guard self.window != nil,
            isHidden != true,
            alpha > 0.01,
            superview != nil
            else {
                return false
        }
        
        // convert self to window's Rect
        var rect: CGRect = superview!.convert(frame, to: nil)
        
        // if size is CGrectZero
        if rect.isEmpty || rect.isNull || rect.size.equalTo(CGSize.zero) {
            return false
        }
        
        // set offset
        if let scorllView = self as? UIScrollView  {
            rect.origin.x += scorllView.contentOffset.x
            rect.origin.y += scorllView.contentOffset.y
        }

        // get the Rect that intersects self and window
        let screenRect: CGRect = UIScreen.main.bounds
        let intersectionRect: CGRect = rect.intersection(screenRect)
        if intersectionRect.isEmpty || intersectionRect.isNull {
            return false
        }
        
        return true
        
    }
}
