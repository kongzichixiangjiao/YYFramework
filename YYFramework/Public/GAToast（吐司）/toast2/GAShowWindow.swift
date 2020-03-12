//
//  GAShowWindow.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/25.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GAShowViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
    }
}

class GAShowWindow: UIWindow {
    
    static var isShowLoading: Bool = false
    
    static func ga_initWindow(frame: CGRect = CGRect.zero) -> GAShowWindow {
        let window = GAShowWindow(frame: frame == CGRect.zero ? UIScreen.main.bounds : frame)
        let vc = GAShowViewController()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        window.windowLevel = .alert + 3
        window.backgroundColor = UIColor.clear
        window.makeKey()
        window.tag = 2020022501
        return window
    }
    
    static func ga_init(windowFrame: CGRect, message: String = "", type: GAToastType, duration: TimeInterval, touchEnable: Bool) {
        let window = ga_initWindow(frame: windowFrame)
        
        if touchEnable {
            let tap = UITapGestureRecognizer(target: window, action: #selector(show_removeFromSuperview))
            window.addGestureRecognizer(tap)
        }
        
        let toastV: GAToast
        toastV = GAToast.loadToastView(type: type)
        toastV.tag = 2020022502
        toastV.frame = window.bounds
        toastV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if type == .message {
            toastV.messageLabel.text = message
        }
        
        window.addSubview(toastV)
        
        window.perform(#selector(show_removeFromSuperview), with: nil, afterDelay: duration)
    }
    
    // MARK: 文案提醒
    static func ga_show(windowFrame: CGRect = CGRect.zero, message: String, duration: TimeInterval = 2.5, touchEnable:Bool = false) {
        ga_init(windowFrame: windowFrame, message: message, type: .message, duration: duration, touchEnable: touchEnable)
    }
    
    // MARK:
    static func ga_show(windowFrame: CGRect = CGRect.zero, type: GAToastType, duration: TimeInterval = 2.5, touchEnable:Bool = false) {
        ga_init(windowFrame: windowFrame, type: type, duration: duration, touchEnable: touchEnable)
    }
    
    // MARK: 自定义View提醒
    static func ga_show(windowFrame: CGRect = CGRect.zero, toastV: UIView, duration: TimeInterval = 2.5, touchEnable:Bool = false) {
        let window = ga_initWindow(frame: windowFrame)
        
        if touchEnable {
            let tap = UITapGestureRecognizer(target: window, action: #selector(show_removeFromSuperview))
            window.addGestureRecognizer(tap)
        }
        
        toastV.tag = 2020022502
        toastV.frame = window.bounds
        toastV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        window.addSubview(toastV)
        
        window.perform(#selector(show_removeFromSuperview), with: nil, afterDelay: duration)
    }
    
    static func ga_showLoading(windowFrame: CGRect = CGRect.zero) {
        if !GAShowWindow.isShowLoading {
            GAShowWindow.isShowLoading = true
            ga_show(windowFrame: windowFrame, type: .loading, duration: 100000)
        }
    }
    
    static func ga_hideLoading() {
        let window = UIApplication.shared.keyWindow as? GAShowWindow
        window?.show_removeFromSuperview()
        GAShowWindow.isShowLoading = false
    }
    
    @objc func show_removeFromSuperview() {
        let window = self.viewWithTag(2020022501) as? UIWindow
        
        let v = self.viewWithTag(2020022502)
        v?.removeFromSuperview()
        
        window?.resignKey()
        window?.isHidden = true
    }
    
}

protocol GAShowWindowProtocol {
    
}

extension GAShowWindowProtocol where Self: GANavViewController {
    func b_showLoading(isAllScreen: Bool = false) {
        if isAllScreen {
            GAShowWindow.ga_showLoading()
        } else {
            let w: CGFloat = 90.0
            let h: CGFloat = 90.0
            let screenW: CGFloat =  UIScreen.main.bounds.width
            let screenH: CGFloat =  UIScreen.main.bounds.height
            GAShowWindow.ga_showLoading(windowFrame: CGRect(x: (screenW - w) / 2, y: (screenH - h) / 2, width: w, height: h))
        }
    }
    
    func b_hideLoading() {
        GAShowWindow.ga_hideLoading()
    }
    
}

extension GAShowWindowProtocol where Self: UIView {
    func b_showLoadingAllScreen() {
        GAShowWindow.ga_showLoading()
    }
    
    func b_hideLoading() {
        GAShowWindow.ga_hideLoading()
    }
}
