//
//  GAVerificationCodeViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/13.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GAVerificationCodeViewController: UIViewController {
    
    @IBOutlet weak var verificationCodeView: GAVerificationCodeView!
    @IBOutlet weak var countDownButton: UIButton!
    
    lazy var coutDown: GATimer = {
        let c = GATimer(sourceTimerCount: 10)
        return c
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _addTimer()
    }
    
    private func _addTimer() {
        coutDown.addTimer {
            [weak self] count, b in
            print(count, b)
            if let weakSelf = self {
                DispatchQueue.main.async {
                    if b {
                        weakSelf.coutDown.cancleTimer()
                        weakSelf.countDownButton.setTitle("获取验证码", for: .normal)
                        return
                    } else {
                        weakSelf.countDownButton.setTitle("\(count)", for: .normal)
                    }
                }
            }
        }
    }
    
    @IBAction func getVerificationCode(_ sender: UIButton) {
        coutDown.timerCount = 10
        _addTimer()
    }
    
    @IBAction func getCode(_ sender: Any) {
        verificationCodeView.updateData(texts: ["1", "7", "2", "5"])
    }
    
    deinit {
        coutDown.cancleTimer()
        print("GAVerificationCodeViewController")
    }
}
