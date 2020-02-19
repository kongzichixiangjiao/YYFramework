//
//  GANormalizeButtonViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/23.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
//import BaiduMobStat

class GANormalizeButtonViewController: GANormalizeBaseViewController {

    @IBOutlet weak var button1: GANormalizeButton!
    @IBOutlet weak var button2: GANormalizeButton!
    @IBOutlet weak var button3: GANormalizeButton!
    @IBOutlet weak var button4: GANormalizeButton!
    @IBOutlet weak var iconButton: GANormalizeIconButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            button1.addEndAction(startState: .normal) {
            [weak self] touchState, state in
            if let weakSelf = self {
                weakSelf.button4.stateType = .normal
            }
        }
        button2.addEndAction { (touchState, state) in
            print("addTarget - ", touchState, state)
        }
        
        button3.addEndAction {
            [weak self] touchState, state in
            if let weakSelf = self {
                weakSelf.button1.stateType = .selected
            }
        }
        
        button4.addEndAction {
            [weak self] touchState, state in
            if let weakSelf = self {
                weakSelf.button2.stateType = .enabled
            }
        }

        button1.stateType = .normal
        button2.stateType = .highlight
        button3.stateType = .selected
        button4.stateType = .enabled
        
        iconButton.p_addTapAction {
            print("addTapAction")
            self.iconButton.p_updateIcon(name: "ic_audiotrack_48pt")
        }
        
    }
    
    @IBAction func action(_ sender: GANormalizeButton) {
        print("action: ", sender.state)
    }
    
    deinit {
        print("deinit GANormalizeButtonViewController")
    }
}

