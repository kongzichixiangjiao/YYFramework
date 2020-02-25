//
//  GAShowWindow.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/25.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

class GAShowViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
    }
}

class GAShowWindow: UIWindow {
    
    static let share: GAShowWindow = GAShowWindow(frame: UIScreen.main.bounds)
    
    var targetView: UIView!
    var smallPreViewFrame: CGRect!
    
    static func ga_initWindow() -> GAShowWindow {
        let window = GAShowWindow(frame: UIScreen.main.bounds)
        let vc = GAShowViewController()
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        window.windowLevel = .alert + 3
        window.backgroundColor = UIColor.clear
        window.makeKey()
        window.tag = 2020022501
        return window
    }
    static func ga_init(message: String = "", type: GAToastType, delay: TimeInterval, touchEnable: Bool) {
        let window = ga_initWindow()
        
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
        
        window.perform(#selector(show_removeFromSuperview), with: nil, afterDelay: delay)
    }
    
    // MARK:
    static func ga_show(message: String, delay: TimeInterval = 2.5, touchEnable:Bool = false) {
        ga_init(message: message, type: .message, delay: delay, touchEnable: touchEnable)
    }
    
    // MARK:
    static func ga_show(type: GAToastType, delay: TimeInterval = 2.5, touchEnable:Bool = false) {
        ga_init(type: type, delay: delay, touchEnable: touchEnable)
    }
    
    // MARK:
    static func ga_show(toastV: UIView, delay: TimeInterval = 2.5, touchEnable:Bool = false) {
        let window = ga_initWindow()
        
        if touchEnable {
            let tap = UITapGestureRecognizer(target: window, action: #selector(show_removeFromSuperview))
            window.addGestureRecognizer(tap)
        }
        
        toastV.tag = 2020022502
        toastV.frame = window.bounds
        toastV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        window.addSubview(toastV)
        
        window.perform(#selector(show_removeFromSuperview), with: nil, afterDelay: delay)
    }
    
    static func ga_showLoading() {
        ga_show(type: .loading, delay: 100000)
    }
    
    static func ga_hideLoading() {
        let window = UIApplication.shared.keyWindow as? GAShowWindow
        window?.show_removeFromSuperview()
    }
    
    @objc func show_removeFromSuperview() {
        let window = self.viewWithTag(2020022501) as? UIWindow
        
        let v = self.viewWithTag(2020022502)
        v?.removeFromSuperview()
        
        window?.resignKey()
        window?.isHidden = true
    }
    
}
