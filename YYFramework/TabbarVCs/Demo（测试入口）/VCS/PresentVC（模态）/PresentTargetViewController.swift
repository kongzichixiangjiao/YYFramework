//
//  PresentTargetViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/19.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class PresentTargetViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.systemVersion.floatValue >= 8.0 {
            self.modalPresentationStyle = .overCurrentContext
        } else {
            self.modalPresentationStyle = .currentContext
        }
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        
        bgView.backgroundColor = UIColor.randomColor()
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
