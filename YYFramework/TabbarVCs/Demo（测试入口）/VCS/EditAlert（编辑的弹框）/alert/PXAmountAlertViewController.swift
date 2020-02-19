//
//  PXAmountAlertViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/12.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class PXAmountAlertViewController: PXEditAlertBaseViewController {

    var models: [GATitleEditModel] = []
    
    lazy var investmentInforView: GAInvestmentInforView = {
        let v = "GAInvestmentInforView".xibLoadView() as! GAInvestmentInforView
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isTapBack = true
        mType = .amount 
        
        if registerNotification {
            _registerNotification()
        }
        
        self.bgView.addSubview(investmentInforView)
        self.bgView.edit_addLayout(top: 0, bottom: 0, left: 0, right: 0, item: investmentInforView)
        investmentInforView.models = models
    }

}
