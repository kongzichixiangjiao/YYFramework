//
//  GAInvestmentInforView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/13.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAInvestmentInforView: UIView {
    
    @IBOutlet var titleEditVeiws: [GATitleEditView]!
    
    var models: [GATitleEditModel]! {
        didSet {
            for i in 0..<titleEditVeiws.count  {
                let t = titleEditVeiws[i]
                let m = models[i]
                t.model = m
                if m.text.isEmpty {
                    t.textField.becomeFirstResponder()
                }
            }
        }
    }
}
