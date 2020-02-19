//
//  GAClockTagViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/27.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GAClockTagViewControllerDelegate: class {
    func clockTagViewControllerBack(text: String, type: ClockPickerType)
}

class GAClockTagViewController: GANavViewController {

    weak var delegate: GAClockTagViewControllerDelegate?
    @IBOutlet weak var textField: GANormalizeTextField!
    
    var fromType: ClockPickerType = .tag 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "怎么叫都叫不醒的" + fromType.rawValue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func b_clickedLeftButtonAction() {
        guard let t = textField.text else {
            return 
        }
        delegate?.clockTagViewControllerBack(text: t.isEmpty ? "小雷闹钟" : t, type: fromType)
        self.navigationController?.popViewController(animated: true)
    }


}
