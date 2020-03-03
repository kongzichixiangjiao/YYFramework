//
//  View+Toast.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/29.
//  Copyright © 2019 houjianan. All rights reserved.
//  吐司 toastt 提醒

/*
    self.view.ga_toast(type: .loading, delay: 30.0)
    self.view.ga_toast(type: .submit_success, delay: 30.0)
    self.view.ga_toast(type: .submit_failure, delay: 30.0)
    self.view.ga_toast(type: .operate_success, delay: 30.0)
    self.view.ga_toast(type: .operate_error, delay: 30.0)
    self.view.ga_toast(message: "小雷闹钟小雷闹钟")
*/
import Foundation

fileprivate let kToastLoadingTag: Int = 20198291

extension UIView {
    
    func ga_toast(type: GAToastType, delay: TimeInterval = 3.0, touchEnable:Bool = false) {
        _toast(type: type, delay: delay, touchEnable: touchEnable)
    }
    
    // message
    func ga_toast(message: String, delay: TimeInterval = 3.0, touchEnable:Bool = false) {
        let toastV: GAToast
        if let view = self.viewWithTag(TextOnlyTag) as? GAToast {
            toastV = view
        } else {
            toastV = GAToast.loadToastView(type: .message)
            toastV.tag = kToastLoadingTag
            toastV.frame = self.bounds
            toastV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        toastV.messageLabel.text = message
        toastV.isUserInteractionEnabled = !touchEnable
        self.addSubview(toastV)
        toastV.perform(#selector(removeFromSuperview), with: nil, afterDelay: delay)
    }
    
    // MARK: loading
    func ga_toastLoading(delay: TimeInterval = 3.0, touchEnable:Bool = false) {
        _toast(type: .loading, delay: delay, touchEnable: touchEnable)
    }
    
    // MARK: submit_success
    func ga_toastSubmit_success(delay: TimeInterval = 3.0, touchEnable:Bool = false) {
        _toast(type: .submit_success, delay: delay, touchEnable: touchEnable)
    }
    
    // MARK: submit_error
    func ga_toastSubmit_error(delay: TimeInterval = 3.0, touchEnable:Bool = false) {
        _toast(type: .submit_failure, delay: delay, touchEnable: touchEnable)
    }
    
    // MARK: operate_success
    func ga_toastOperate_success(delay: TimeInterval = 3.0, touchEnable:Bool = false) {
        _toast(type: .operate_success, delay: delay, touchEnable: touchEnable)
    }
    
    // MARK: operate_error
    func ga_toastOperate_error(delay: TimeInterval = 3.0, touchEnable:Bool = false) {
        _toast(type: .operate_error, delay: delay, touchEnable: touchEnable)
    }
    
    private func _toast(type: GAToastType, delay: TimeInterval = 3.0, touchEnable:Bool = false) {
        let toastV: GAToast
        if let view = self.viewWithTag(TextOnlyTag) as? GAToast {
            toastV = view
        } else {
            toastV = GAToast.loadToastView(type: type)
            toastV.tag = kToastLoadingTag
            toastV.frame = self.bounds
            toastV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        toastV.isUserInteractionEnabled = !touchEnable
        self.addSubview(toastV)
        toastV.perform(#selector(removeFromSuperview), with: nil, afterDelay: delay)
    }
    
}

