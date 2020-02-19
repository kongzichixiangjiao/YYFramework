//
//  YYLoginViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/27.
//  Copyright © 2018年 houjianan. All rights reserved.
//

// AppID：wx56a2b2b630dd4ce5

import UIKit
import GAAlertPresentation

enum YYLoginVCBackEnum {
    case pop, dismiss, root(vc: UIViewController)
}

class YYLoginViewController: GAAppleIDLoginViewController {
    
    var backWay: YYLoginVCBackEnum = .dismiss
    
    @IBOutlet weak var appleIDButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            let v = initAuthorizationAppleIDButton()
            v.frame = CGRect(x: 0, y: 0, width: kScreenWidth - 20.0 * 2, height: 50)
            appleIDButton.addSubview(v)
        } else {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: Any) {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let bundle = Bundle.ga_podBundle(aClass: PXPhotoSheetViewController.classForCoder(), resource: "GAAlertPresentation")
        let vc = PXPhotoSheetViewController(nibName: "PXPhotoSheetViewController", bundle: bundle, delegate: d)
        vc.clickedHandler = {
            tag, model in
            if (tag == 1) {
                self._finish()
            } else if (tag == 2) {
                self._finish()
            } else {
                
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func wxLogin(_ sender: Any) {
        GAWXLib.share.login(vc: self, successHandler: { (token) in
            print("登陆成功，token = ", token)
            self.view.show(token as! String)
            self._finish()
        }) { (type) in
            switch type {
            case .cancle:
                print("点击取消")
                break
            case .sendFinished:
                print("发送完成")
                break
            case .error:
                print("登录失败 的操作")
                break
            case .otherError: break
            }
        }
    }
    
    @IBAction func qywxLogin(_ sender: Any) {
        GAWeChat.share.login(successHandler: { (token) in
            print("登陆成功，token = ", token)
            self.view.show(token as! String)
        }) { (type) in
            switch type {
            case .cancle:
                print("点击取消")
                break
            case .sendFinished:
                print("发送完成")
                break
            case .error:
                print("登录失败 的操作")
                break
            case .otherError: break
            }
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        _finish()
    }
    
    private func _finish() {
        switch backWay {
        case .pop:
            self.navigationController?.popViewController(animated: true)
            break
        case .dismiss:
            self.dismiss(animated: true, completion: nil)
            break
        case .root(let vc):
            UIApplication.shared.keyWindow?.rootViewController = vc
            break
        }
    }
    
    override func loginSuccess(_ userIdentifier: String, _ personName: PersonNameComponents?, _ email: String) {
        _finish()
    }
}
