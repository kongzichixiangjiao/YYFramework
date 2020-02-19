//
//  ZHTimePickerViewController.swift
//  eduOnline
//
//  Created by houjianan on 2019/6/6.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit
import GAAlertPresentation

class ZHTimePickerViewController: YYPresentationBaseViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirm(_ sender: Any) {
        print(datePicker.date)
        clickedHandler?(2, datePicker.date)
    }
    

}
