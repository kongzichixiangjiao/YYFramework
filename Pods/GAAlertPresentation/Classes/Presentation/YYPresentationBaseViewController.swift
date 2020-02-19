//
//  YYPresentationBaseViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

/*
     var alertClickedHandler: YYPresentationBaseViewController.ClickedHandler = {
         tag in
         print(tag)
     }
 */

/*
     let d = YYPresentationDelegate(animationType: <#PresentationAnimationType#>)
     let vc = <#YYPresentationBaseViewController#>(nibName: "<#YYPresentationBaseViewController#>", bundle: nil, deleYYte: d)
     vc.clickedHandler = {
        tag in
        print(tag)
     }
     self.present(vc, animated: true, completion: nil)
 */

open class YYPresentationBaseViewController: UIViewController {
    
    // 点击弹框按钮的闭包
    public typealias ClickedHandler = (_ tag: Int, _ model: Any?) -> ()
    public var clickedHandler: ClickedHandler?
    public var isTapBack: Bool = true
    private var isDismiss: Bool = false
    
//    public var isShowMaskView: Bool = false
//    public var maskViewBackColor: UIColor = UIColor.clear
    
    public var duration: Double = 0 // 多长时间 只有执行mTimer方法
    private var mTimer: Timer?
    
    private var mDeleYYte: YYPresentationDelegate?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if duration != 0 {
            mTimer = Timer.scheduledTimer(timeInterval: duration + 0.5, target: self, selector: #selector(selfDismiss(_:)), userInfo: nil, repeats: false)
        }
        
    }
    
    @objc func selfDismiss(_ timer: Timer) {
        dismiss()
    }
    
    convenience public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, delegate: YYPresentationDelegate?) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        guard let d = delegate else {
            let de = YYPresentationDelegate(animationType: .middle)
            self.transitioningDelegate = de
            self.mDeleYYte = de
            return
        }
        self.transitioningDelegate = d
        self.mDeleYYte = d
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
   
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch in touches {
            guard let v = touch.view else {
                return
            }
            if self.view == v {
                if isTapBack {
                    if !isDismiss {
                        dismiss()
                    }
                }
            }
        }
    }
    
    public func dismiss(completion: (() -> Swift.Void)? = nil) {
        if isDismiss {
            completion?()
        }
        guard let d = mDeleYYte else {
            let de = YYPresentationDelegate(animationType: .middle)
            self.transitioningDelegate = de
            self.dismiss(animated: true) {
                completion?()
            }
            self.isDismiss = true
            return
        }
        
        let de = YYPresentationDelegate(animationType: d.presentationAnimationType)
        self.transitioningDelegate = de
        self.dismiss(animated: true) {
            completion?()
        }
        self.isDismiss = true
    }
    
    deinit {
        /*
         计时器暂停
         self.playerTimer.fireDate = Date.distantFuture
         计时器继续
         self.playerTimer.fireDate = Date.distantPast
         */
        self.mTimer?.invalidate()
    }
}

