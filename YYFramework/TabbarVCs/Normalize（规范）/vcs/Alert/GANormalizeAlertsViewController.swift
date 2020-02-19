//
//  GANormalizeAlertsViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/13.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class GANormalizeAlertsViewController: GANormalizeBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func defaultAlert(_ sender: Any) {
        showDefaultAlert()
        
//        showSystemAlert()
        
        let _ = sum(a: 100)
    
        
    }
    
    func sum(a: Int) -> Int {
        if a == 1 {
            return 1
        }
        return a + sum(a: a - 1)
    }
    
    func showDefaultAlert() {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: kMaskLayerColor)
        let bundle = Bundle.ga_podBundle(aClass: AnimationBaseViewController.classForCoder(), resource: "GAAlertPresentation")
        let vc = AnimationBaseViewController(nibName: "AnimationBaseViewController", bundle: bundle, delegate: d)
        vc.clickedHandler = {
            tag, model in
            print(tag)
            self.dismiss(animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func showSystemAlert() {
        let alertController = UIAlertController(title: "", message: "有新版本可以使用，请去更新", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "确定", style: UIAlertAction.Style.default) { (UIAlertAction) in
        }
        alertController.addAction(okAction)
        let cancleAction = UIAlertAction(title: "取消", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(cancleAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func alertOnlyBottom(_ sender: Any) {
        let d = YYPresentationDelegate(animationType: .alert, isShowMaskView: true, maskViewColor: kMaskLayerColor)
        let bundle = Bundle.ga_podBundle(aClass: PXAlertOnlyBottomViewController.classForCoder(), resource: "GAAlertPresentation")
        let vc = PXAlertOnlyBottomViewController(nibName: "PXAlertOnlyBottomViewController", bundle: bundle, delegate: d)
        vc.clickedHandler = {
            tag, model in
            print(tag)
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
