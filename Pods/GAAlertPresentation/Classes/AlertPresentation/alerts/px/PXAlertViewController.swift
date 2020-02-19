//
//  PXAlertViewController.swift
//  IFA-B
//
//  Created by 侯佳男 on 2018/8/14.
//  Copyright © 2018年 ZHENGHEHOLDING. All rights reserved.
//

import UIKit

open class PXAlertViewController: YYPresentationBaseViewController {

    @IBOutlet weak var titleAlertLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancle(_ sender: Any) {
        clickedHandler!(0, nil)
        dismiss()
    }
    
    @IBAction func confirm(_ sender: Any) {
        clickedHandler!(1, nil)
        dismiss()
    }
    

}
