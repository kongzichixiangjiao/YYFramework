//
//  YYReuseTimer.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/9/26.
//  Copyright © 2019 houjianan. All rights reserved.
//  轮播图循环专用 

import Foundation

class YYReuseTimer {
    
    typealias YYReuseTimerHandler = (_ count: Int, _ finished: Bool) -> ()
    
    // 定时器timer
    private var timer: DispatchSourceTimer?
    // 倒计时计数使用
    private var _timerCount: Int = 1
    private var _interval: Int = 1
    private var _isRepeat: Bool = false
    
    convenience init(sourceTimerCount: Int = 1, interval: Int = 1, isRepeat: Bool = false) {
        self.init()
        self._timerCount = sourceTimerCount
        self._isRepeat = isRepeat
        self._interval = interval
    }
    
    // 添加倒计时方法
    public func addTimer(handler: @escaping YYReuseTimerHandler) {
        // 子线程创建timer
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //        let timer = DispatchSource.makeTimerSource()
        /*
         dealine: 开始执行时间
         repeating: 重复时间间隔
         leeway: 时间精度
         */
        timer?.schedule(deadline: .now() + .seconds(0), repeating: DispatchTimeInterval.seconds(_interval), leeway: DispatchTimeInterval.seconds(0))
        // timer 添加事件
        timer?.setEventHandler {
            self._timerCount -= 1
            print(Date())
            // 倒计时结束
            if (self._timerCount == 0) {
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
                    handler(self._timerCount, false)
                }
            }
        }
        timer?.resume()
    }
    
    // timer暂停
    public func stopTimer() {
        timer?.suspend()
    }
    
    public func goOnTimer() {
        timer?.resume()
    }
    
    // timer结束
    public func cancleTimer() {
        guard let t = timer else {
            return
        }
        t.resume()
        t.cancel()
        timer = nil
    }
    
    deinit {
        #if DEBUG
        print("deinit YYReuseTimer")
        #endif
    }
}

