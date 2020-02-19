//
//  GAScreeningViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/31.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAScreeningViewController: GANavViewController {
    
    lazy var screeningView: GAScreenintView = {
        let v = GAScreenintView()
        v.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    lazy var screeningXibView: GAScreenintView = {
        let v = "GAScreenintView".xibLoadView() as! GAScreenintView
        v.frame = CGRect(x: 0, y: 0, width: 300, height: self.view.height)
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "筛选")
    }
    
    @IBAction func rightDefault(_ sender: Any) {
        //                GAAnimationWindow.share.show(v: screeningView, type: .default, direction: .right, handler: {
        //                    [weak self] in
        //                    if let _ = self {
        //
        //                    }
        //                })
        
        GAAnimationWindow.share.show(v: screeningXibView, type: .default, direction: .right, handler: {
            [weak self] in
            if let _ = self {
                
            }
        })
    }
    
    @IBAction func middleAlert(_ sender: Any) {
        GAAnimationWindow.share.show(v: screeningXibView, type: .alert, direction: .middle, handler: nil)
    }
    
    @IBAction func leftSheet(_ sender: Any) {
        GAAnimationWindow.share.show(v: screeningXibView, type: .sheet, direction: .left, handler: nil)
    }
    
    @IBAction func rightSheet(_ sender: Any) {
        GAAnimationWindow.share.show(v: screeningView, type: .sheet, direction: .right, handler: nil)
    }
    
    @IBAction func bottomSheet(_ sender: Any) {
        let v = GAScreenintView()
        v.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        v.backgroundColor = UIColor.randomColor()
        
        GAAnimationWindow.share.show(v: v, type: .sheet, direction: .bottom, handler: nil)
    }
    
    
    @IBAction func sorting(_ sender: UIButton) {
        
    }
    
    @IBAction func screening(_ sender: UIButton) {
        
    }
}
