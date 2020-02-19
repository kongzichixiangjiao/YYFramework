//
//  PresentTargetCustomeViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/31.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class PresentTargetCustomeViewController: YYPresentationBaseViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var tLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgView.backgroundColor = UIColor.randomColor()
        
        isTapBack = true 
    }
    
    @IBAction func closed(_ sender: Any) {
        dismiss()
    }

}
