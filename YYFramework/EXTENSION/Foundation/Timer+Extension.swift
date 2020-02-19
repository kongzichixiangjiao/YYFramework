//
//  Timer+Extension.swift
//  FinancialPlanner
//
//  Created by houjianan on 2019/9/24.
//  Copyright © 2019 PUXIN. All rights reserved.
//

import Foundation

// 写一个Timer的分类。
extension Timer {
    class func ga_scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
        }
        return scheduledTimer(timeInterval: interval, target: self, selector: #selector(ga_handerTimerAction), userInfo: Block(block), repeats: true)
    }
    
    // 一定要加class。 Timer是类对象，只能调用类方法，不能调用实例方法（否则报错：[NSTimer xx_handerTimerAction:]: unrecognized selector sent to class 0x1105c30c0'）
    @objc class func ga_handerTimerAction(_ sender: Timer) {
        if let block = sender.userInfo as? Block<(Timer) -> Void> {
            block.type(sender)
        }
    }
}

//Block模型类
class Block<T> {
    let type: T
    init(_ type: T) {
        self.type = type
    }
}
