//
//  GAToastRootViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/25.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GAToastRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func show(_ sender: Any) {
        GAShowWindow.ga_show(message: "12312312313123123")
    }

    @IBAction func show_message_tap(_ sender: Any) {
        GAShowWindow.ga_show(message: "可以点击移除-10秒", duration: 10, touchEnable: true)
    }
    
    @IBAction func show_type_error(_ sender: Any) {
        GAShowWindow.ga_show(type: .operate_error)
    }
    
    @IBAction func show_type_loading(_ sender: Any) {
        GAShowWindow.ga_show(type: .loading)
    }
    
    @IBAction func show_loading(_ sender: Any) {
        GAShowWindow.ga_showLoading()
        
        self.perform(#selector(hideLoading), with: nil, afterDelay: 5)
    }
    
    @objc func hideLoading() {
        GAShowWindow.ga_hideLoading()
    }
    
    @IBAction func show_message_frame(_ sender: Any) {
        GAShowWindow.ga_show(windowFrame: CGRect(x: 100, y: 100, width: 100, height: 100), type: .operate_error)
    }
    
}
