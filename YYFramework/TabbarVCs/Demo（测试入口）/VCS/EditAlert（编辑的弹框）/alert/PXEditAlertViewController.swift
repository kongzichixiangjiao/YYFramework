//
//  PXEditAlertViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/11.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class PXEditAlertModel {
    var title: String = ""
    var placeHolder: String = ""
    var unit: String = ""
    var text: String = ""
}

class PXEditAlertViewController: PXEditAlertBaseViewController {

    @IBOutlet weak var textField: GANormalizeTextField!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: PXEditAlertModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isTapBack = true
        
        mType = .edit 
        
        _registerNotification()
        
        textField.text = model.text 
        textField.placeholder = model.placeHolder
        titleLabel.text = model.title
        unitLabel.text = model.unit
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textField.becomeFirstResponder()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clickedHandler?(1, textField.text ?? "")
    }
    
}

