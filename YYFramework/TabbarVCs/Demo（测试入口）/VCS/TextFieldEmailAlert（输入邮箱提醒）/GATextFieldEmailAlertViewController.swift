//
//  GATextFieldEmailAlertViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/15.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GATextFieldEmailAlertViewController: GANavViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var sourceData = ["@qq.com", "@163.com", "@puxin.com", "@google.cn"]
    
    lazy var textFieldEmailAlertView: GATextFieldEmailAlertView = {
        let v = GATextFieldEmailAlertView(frame: CGRect(x: textField.x, y: textField.maxY, width: textField.width, height: CGFloat(sourceData.count) * 40.0), sourceData: self.sourceData)
        v.delegate = self
        v.backgroundColor = UIColor.randomColor()
        self.view.addSubview(v)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "输入框邮箱提醒")
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        textFieldEmailAlertView.reload(text: textField.text ?? "")
    }
    
}

extension GATextFieldEmailAlertViewController: GATextFieldEmailAlertViewDelegate {
    func textFieldEmailAlertViewDidSelected(text: String) {
        textField.text = text
    }
}

extension GATextFieldEmailAlertViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldEmailAlertView.show()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldEmailAlertView.hide()
    }
    
}
