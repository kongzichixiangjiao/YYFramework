//
//  GAThemeViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/21.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormalizeThemeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func red(_ sender: UIButton) {
        GAThemes.switchTo(.red)
    }
    
    @IBAction func yellow(_ sender: UIButton) {
        GAThemes.switchTo(.yello)
    }
    
}
