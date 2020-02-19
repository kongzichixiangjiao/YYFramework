//
//  GAEditAlertViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/11.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation
import SnapKit

class GAEditAlertViewController: GANavViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "alert")
        
        for i in 0..<8 {
            let m = GATitleEditModel()
            m.title = "输入金额" + String(i)
            if i == 3 || i == 4 {
                m.text = ""
            } else {
                m.text = "标题" + String(i)
            }
            models.append(m)
        }
        
        let v = "GAInvestmentInforView".xibLoadView() as! GAInvestmentInforView
        self.view.addSubview(v)
        v.models = models
        v.snp.makeConstraints { (make) in
            make.top.equalTo(200)
            make.left.right.equalTo(0)
            make.height.equalTo(400)
        }
    }
    
    @IBAction func show(_ sender: Any) {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let vc = PXEditAlertViewController(nibName: "PXEditAlertViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            [weak self] tag, model in
            if let _ = self {
                print(tag, model ?? "")
            }
        }
        let model = PXEditAlertModel()
        model.title = "我是开发"
        model.text = ""
        model.unit = ""
        model.placeHolder = "随便输入点啥都行"
        vc.model = model 
        self.present(vc, animated: true, completion: nil)
        
        for m in models {
            print(m.text)
        }
    }
    
    var models = [GATitleEditModel]()
    @IBAction func showAmount(_ sender: Any) {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let vc = PXAmountAlertViewController(nibName: "PXAmountAlertViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            [weak self] tag, model in
            if let _ = self {
                print(tag, model ?? "")
            }
        }
        vc.models = models
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showAQ(_ sender: Any) {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let vc = PXAnswerQuestionsAlertViewController(nibName: "PXAnswerQuestionsAlertViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            [weak self] tag, model in
            if let _ = self {
                print(tag, model ?? "")
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
}
