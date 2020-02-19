//
//  YYNewPaperConfig.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/13.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import Foundation
import UIKit

open class YYNewPaperConfig {
    var sourceTimerCount: Int = 5
    var dataSource: [String] = ["img_003.jpg"]
    var size: CGSize = UIScreen.main.bounds.size
    var lastButtonTitle: String = "开启新玩法"
    var isShowLastButton: Bool = false
    
    lazy var lastButton: UIButton? = {
        let b = UIButton()
        b.frame = self.lastButtonFrame
        b.backgroundColor = UIColor.black
        b.setTitle(self.lastButtonTitle, for: UIControl.State.normal)
        b.isHidden = true
        b.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return b
    }()
    
    var lastButtonFrame: CGRect = CGRect(x: UIScreen.main.bounds.size.width - 100 - 20, y: UIScreen.main.bounds.size.height - 40 - 60, width: 100, height: 40)
    
    var isShowTimer: Bool = false
    
    lazy var countDownButton: UIButton = {
        let b = UIButton(type: UIButton.ButtonType.custom)
        b.frame = self.countDownFrame
        b.backgroundColor = UIColor.black
        b.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        b.setTitle(String(sourceTimerCount), for: UIControl.State.normal)
        return b
    }()
    
    var countDownFrame: CGRect = CGRect(x: UIScreen.main.bounds.size.width - 40 - 30, y: 40, width: 60, height: 30)
}
