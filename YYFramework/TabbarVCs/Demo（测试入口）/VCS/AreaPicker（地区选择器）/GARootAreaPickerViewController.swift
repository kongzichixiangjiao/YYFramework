//
//  GARootAreaPickerViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/23.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GARootAreaPickerViewController: GANavViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "地区选择器")
    }
    
    @IBAction func root(_ sender: UIButton) {
        let vc = GAAreaPickerViewController(nibName: "GAAreaPickerViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    

}
