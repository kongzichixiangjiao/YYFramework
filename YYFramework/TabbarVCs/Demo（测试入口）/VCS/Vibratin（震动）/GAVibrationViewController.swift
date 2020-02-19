//
//  GAVibrationViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/22.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import AudioToolbox

class GAVibrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func action(_ sender: Any) {
        // 设置需要开启震动
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
}
