//
//  YYRootViewController.swift
//  YYFramework
//
//  Created by houjianan on 2018/8/11.
//  Copyright © 2018年 houjianan. All rights reserved.
//

/*
lazy var rootVC: YYRootViewController? = {
    let vc = self.parent
    let vcString = vc?.ga_nameOfClass
    if (vcString == "UITabBarController") {
        let tab = vc as! UITabBarController
        return tab.parent as? YYRootViewController
    } else if (vcString == "UINavigationViewController") {
        let nav = vc as! UINavigationController
        let tab = vc?.parent as! UITabBarController
        return tab.parent as? YYRootViewController
    }
    return YYRootViewController()
}()
 */

import UIKit

class YYRootViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollUpView: UIView!
    
    @IBOutlet weak var scrollTopSpace: NSLayoutConstraint!
    @IBOutlet weak var scrollLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var scrollBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var scrollRightSpace: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        root_registerNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        #if DEBUG
        print(scrollView.contentOffset.y)
        #endif
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension YYRootViewController {
    
    func root_registerNotification() {
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
        
        UIView.animate(withDuration: duration) {
            if self.scrollBottomSpace != nil {
                self.scrollBottomSpace.constant = h
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyBoardWillHide(_ notification:Notification) {
        let userInfo = notification.userInfo
        let duration = (userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue

        UIView.animate(withDuration: duration) {
            if self.scrollBottomSpace != nil {
                self.scrollBottomSpace.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func root_releaseNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
