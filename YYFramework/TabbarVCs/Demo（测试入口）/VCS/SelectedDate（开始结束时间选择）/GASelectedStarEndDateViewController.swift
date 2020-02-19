//
//  GASelectedStarEndDateViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/9.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GASelectedStarEndDateViewController: GANavViewController {
    
    private let kStackViewHeight: CGFloat = 200
    
    lazy var pickView: GAPickerView = {
        let v = GAPickerView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 40 * 5), dataSource: dataSource, configModel: nil)
        return v
    }()
    
    var dataSource = [["2015", "2016", "2017", "2018", "2019", "2020"], ["年"], ["1", "2", "3"], ["月"], ["1", "2", "3", "4"], ["日"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        b_showNavigationView(title: "pickerView选择器")
        
        self.view.addSubview(pickView)
    }
}
