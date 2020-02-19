//
//  GASelectedDateViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/9.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class GASelectedDateViewController: GANavViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        b_showNavigationView(title: "开始-结束 时间选择器")
    }

    @IBAction func show(_ sender: Any) {
        let vc = GASelectedStarEndDateViewController(nibName: "GASelectedStarEndDateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
