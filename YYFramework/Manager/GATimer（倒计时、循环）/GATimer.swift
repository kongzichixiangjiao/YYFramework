//
//  GATimer.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/13.
//  Copyright © 2018年 houjianan. All rights reserved.
//  倒计时工具类 定时


/*
 {
 coutDown.addTimer { (count, b) in
 print(count, b)
 }
 }
 
 lazy var coutDown: GATimer = {
 let c = GATimer(sourcetimerCount: 20)
 return c
 }()
 deinit {
 coutDown.cancleTimer()
 }
 
 */
import Foundation

class GATimer {
    
    typealias GATimerHandler = (_ count: Int, _ finished: Bool) -> ()
    
    // 定时器timer
    private var timer: DispatchSourceTimer?
    // 倒计时计数使用
    var timerCount: Int = 1
    private var _isRepeat: Bool = false
    
    convenience init(sourceTimerCount: Int = 1, isRepeat: Bool = false) {
        self.init()
        self.timerCount = sourceTimerCount
        self._isRepeat = isRepeat
    }
    
    // 添加倒计时方法
    public func addTimer(handler: @escaping GATimerHandler) {
        // 子线程创建timer
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //        let timer = DispatchSource.makeTimerSource()
        /*
         dealine: 开始执行时间
         repeating: 重复时间间隔
         leeway: 时间精度
         */
        timer?.schedule(deadline: .now() + .seconds(0), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))
        // timer 添加事件
        timer?.setEventHandler {
            self.timerCount -= 1
            // 倒计时结束
            if (self.timerCount == 0) {
                // 取消倒计时
                // 如果是循环事件 不主动停止
                if !self._isRepeat {
                    self.cancleTimer()
                    handler(-1, true)
                }
            } else {
                // 倒计时更改UI
                if self._isRepeat {
                    handler(0, false)
                } else {
                    handler(self.timerCount, false)
                }
            }
        }
        timer?.resume()
    }
    
    // timer暂停
    public func stopTimer() {
        timer?.suspend()
    }
    
    // timer结束
    public func cancleTimer() {
        guard let t = timer else {
            return
        }
        t.cancel()
        timer = nil
    }
    
    deinit {
        #if DEBUG
        print("deinit GATimer")
        #endif
    }
}


