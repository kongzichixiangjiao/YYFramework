//
//  PXEditAlertBaseViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/12.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

enum EditAlertType: Int {
    case edit = 1, amount = 2, aq = 3
}

class PXEditAlertBaseViewController: YYPresentationBaseViewController {
    
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBOutlet weak var bgView: UIView!
    
    var registerNotification: Bool = true
    var mType: EditAlertType = .edit 
    
    var safeBottomHeight: CGFloat {
        if #available(iOS 11.0, *) {
            guard let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
                return 0
            }
            return safeAreaInsets.bottom
        } else {
            return 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func _registerNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow(_ :)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillHide(_ :)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func keyBoardWillShow(_ notification:Notification) {
        let userInfo = notification.userInfo
        let keyboardRect = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let h = keyboardRect.size.height
        let duration = (userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        self.bottom.constant = h - (mType == .amount ? safeBottomHeight : 0)
        
        UIView.animate(withDuration: duration) {
            self.bgView.layoutIfNeeded()
            self.bgView.superview?.layoutIfNeeded()
        }
    }
    
    @objc func keyBoardWillHide(_ notification:Notification) {
        let userInfo = notification.userInfo
        let duration = (userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        self.bottom.constant = 0
        
        UIView.animate(withDuration: duration) {
            self.bgView.layoutIfNeeded()
            self.bgView.superview?.layoutIfNeeded()
        }
    }
    
    deinit {
        _releaseNotification()
    }
    
    fileprivate func _releaseNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}
