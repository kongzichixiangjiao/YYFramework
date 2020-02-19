//
//  GANoralizeTestTextFieldViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/18.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANoralizeTestTextFieldViewController: UIViewController {

    @IBOutlet weak var t1: GANormalizeTextField!
    @IBOutlet weak var t2: GANormalizeTextField!
    @IBOutlet weak var t3: GANormalizeTextField!
    @IBOutlet weak var t4: GANormalizeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        t1.mDelegate = self
        t2.mDelegate = self
        t3.mDelegate = self
        t4.mDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        print("GANoralizeTestTextFieldViewController - deinit")
    }
}

extension GANoralizeTestTextFieldViewController: GANormalizeTextFieldDelegate {
    func normalizeTextFieldEditingRect(textField: GANormalizeTextField) -> CGRect {
        return CGRect(x: 40, y: 0, width: 200, height: 40)
    }
}
