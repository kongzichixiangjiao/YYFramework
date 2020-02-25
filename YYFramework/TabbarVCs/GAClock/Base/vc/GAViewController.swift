//
//  ViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAViewController: UIViewController {
    
    // 是否监听屏幕方向更改
    public var b_isAddOrientationNotification: Bool = false {
        didSet {
            if b_isAddOrientationNotification {
                _addDeviceOrientationNotification()
            }
        }
    }
    
    // 当前屏幕方向
    // UIApplication.shared.statusBarOrientation
    public var b_currentScreenOrientation: UIInterfaceOrientation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = GABaseBackColor
        
        automaticallyAdjustsScrollViewInsets = false
    }

    var onceLayoutSubviews: Int = 0
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if onceLayoutSubviews == 0 {
            b_viewDidLayoutSubviews()
            onceLayoutSubviews += 1
        }
    }
    
    func b_viewDidLayoutSubviews() {
        
    }
    
    @objc private func _applicationWillChangeStatusBarOrientationNotification(sender: Notification) {
      if let userInfo = sender.userInfo {
          if let rawValue = userInfo[UIApplication.statusBarOrientationUserInfoKey] as? Int {
              if let orientation = UIInterfaceOrientation(rawValue: rawValue) {
                  if b_currentScreenOrientation == orientation {
                      return
                  }
                  b_updateNavigationViewLayout(type: orientation)
                  b_currentScreenOrientation = orientation
              }
          }
      }
    }
    
    public func b_updateNavigationViewLayout(type: UIInterfaceOrientation) {
        
    }
    
    private func _addDeviceOrientationNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(_applicationWillChangeStatusBarOrientationNotification(sender:)), name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
    }

    private func _removeDeviceOrientationNotification() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
    }

    deinit {
        if b_isAddOrientationNotification {
            _removeDeviceOrientationNotification()
        }
    }
}













