//
//  PXAlertOnlyBottomViewController.swift
//  IFA-B
//
//  Created by summer on 2018/9/5.
//  Copyright © 2018年 ZHENGHEHOLDING. All rights reserved.
//

import UIKit

open class PXAlertOnlyBottomViewController: YYPresentationBaseViewController {

    @IBOutlet weak var contentLabel: UILabel!
    
    var text: String =  ""
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentLabel.text = text  
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func logOutAction(_ sender: Any) {
        clickedHandler!(1, nil)
        dismiss()
    }
}
