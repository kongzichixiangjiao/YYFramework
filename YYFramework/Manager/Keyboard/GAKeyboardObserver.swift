//
//  Keyboard.swift
//  Need
//
//  Created by houjianan on 2020/3/19.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

protocol GAKeyboardProtocol {
    
}

extension GAKeyboardProtocol where Self: GAKeyboardObserver {
    func keyboard_addObserver(showSelector: Selector, hideSelector: Selector) {
        NotificationCenter.default.addObserver(self,
                                               selector: showSelector,
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: hideSelector,
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func keyboard_releaseNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

class GAKeyboardObserver: GAKeyboardProtocol {

    typealias ObserverHandler = (_ h: CGFloat, _ duration: Double) -> ()
    var beginHandler: ObserverHandler!
    var endHandler: ObserverHandler!
    
    convenience init(view: UIView, beginHandler: @escaping ObserverHandler, endHandler: @escaping ObserverHandler) {
        self.init()
        
        self.beginHandler = beginHandler
        self.endHandler = endHandler
        
        keyboard_addObserver(showSelector: #selector(keyBoardWillShow(_ :)), hideSelector: #selector(keyBoardWillHide(_ :)))
    }
    
    @objc func keyBoardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardRect = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let h = keyboardRect.size.height
        let duration = (userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        self.beginHandler(h, duration)
    }
    
    @objc func keyBoardWillHide(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardRect = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let h = keyboardRect.size.height
        let duration = (userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        self.endHandler(h, duration)
    }
    
    func keyboard_releaseNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
