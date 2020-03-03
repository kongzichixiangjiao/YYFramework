//
//  GARxRootViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/9/23.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GARxRootViewController: GANavViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "RxRoot")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        print("tappppp")
    }
    
    
    @IBAction func action(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = GAExerciseViewController(nibName: "GAExerciseViewController", bundle: nil)
            self.yy_push(vc: vc)
            break
        case 1:
            yy_push(storyboardName: "SimpleValidation")
            break
        case 2:
            
            break
        case 3:
            yy_push(storyboardName: "rxTableView")
            break
        default:
            break
        }
    }
    
    deinit {
        #if DEBUG
        print("GARxRootViewController")
        #endif
    }
    
}
