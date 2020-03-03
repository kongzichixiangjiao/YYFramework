//
//  GAAlert.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/27.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

//
//  GAShowWindow.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/25.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

enum GAAlertType: String {
    case normal = "normal", base = "base"
}

class GAAlertViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
    }
}

class GAAlertWindow: UIWindow {
    
    static let share: GAAlertWindow = GAAlertWindow(frame: UIScreen.main.bounds)
    
    private func _initWindow(frame: CGRect = CGRect.zero) {
        let vc = GAAlertViewController()
        
        self.rootViewController = vc
        self.makeKeyAndVisible()
        self.windowLevel = .alert + 3
        self.backgroundColor = UIColor.orange
        self.makeKey()
        self.tag = 2020022801
    }
    
    private func _initTap() {
        let tap = UITapGestureRecognizer(target: window, action: #selector(_removeFromSuperview))
        self.addGestureRecognizer(tap)
    }
    
    func _init(type: GAAlertType, touchEnable: Bool, handler: @escaping GAAlertHandler) {
        _initWindow()
        
        if touchEnable {
            _initTap()
        }
        
        let alertV = ga_initAlertView(type: type, handler: handler)
        alertV.tag = 2020022802
        
        self.addSubview(alertV)
    }
    
    func ga_initAlertView(type: GAAlertType, handler: @escaping GAAlertHandler) -> UIView {
        let v = GAAlertBaseView.loadView(type: type) as! GAAlertBaseView
        v.handler = {
            [weak self] tag, model in
            if let weakSelf = self {
                if tag == .cancle {
                    weakSelf.hide()
                }
                handler(tag, model)
            }
        }
        return v
    }
    
    func ga_show(type: GAAlertType, touchEnable: Bool = false, handler: @escaping GAAlertHandler) {
        _init(type: type, touchEnable: touchEnable, handler: handler)
    }
    
    @objc func _removeFromSuperview() {
        let v = self.viewWithTag(2020022802)
        v?.removeFromSuperview()
        
        self.resignKey()
        self.isHidden = true
    }
    
    func hide() {
        _removeFromSuperview()
    }
    
}

class GAAlertWindow1: GAAlertWindow {
    
    static let share1: GAAlertWindow1 = GAAlertWindow1(frame: UIScreen.main.bounds)
    
    override func ga_initAlertView(type: GAAlertType, handler: @escaping GAAlertHandler) -> UIView {
        let v = GAAlertCustomerView.loadView(type: type) as! GAAlertCustomerView
        v.handler = {
            [weak self] tag, model in
            if let weakSelf = self {
                
            }
        }
        return v
    }
}
