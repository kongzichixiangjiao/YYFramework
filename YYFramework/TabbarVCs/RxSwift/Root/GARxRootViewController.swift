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
    }
    
    @IBAction func action(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = GAExerciseViewController(nibName: "GAExerciseViewController", bundle: nil)
            self.yy_push(vc: vc)
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
