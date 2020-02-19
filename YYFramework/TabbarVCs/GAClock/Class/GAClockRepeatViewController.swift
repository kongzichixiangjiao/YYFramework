//
//  GAClockRepeatViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/27.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class GAClockRepeatViewController: YYPresentationBaseViewController {
    
    @IBOutlet var weekViews: [GACustomCellView]!
    
    @IBOutlet var checkButtons: [UIButton]!
    
    var weekSring: [String] = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isTapBack = false
        
        for week in weekViews {
            week.didClick = {
                let checkBtn = self.checkButtons[week.tag]
                checkBtn.isSelected = !checkBtn.isSelected
            }
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        var arr = [String]()
        for i in 0..<checkButtons.count {
            if checkButtons[i].isSelected {
                let week = weekSring[i]
                arr.append(week)
            }
        }
        
        let s = arr.joined(separator: ",")
        self.clickedHandler?(1, s)
        self.dismiss()
    }
    
    @IBAction func cancle(_ sender: Any) {
        self.clickedHandler?(0, "取消")
        self.dismiss()
    }
}
