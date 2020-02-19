//
//  GANormalizePickerViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/20.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class GANormalizePickerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showData(_ sender: Any) {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let vc = ZHDataPickerViewController(nibName: "ZHDataPickerViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            tag, model in
            print(tag, model ?? "model = nil")
        }
        //        vc.dataSource = [["老大", "小二", "贼三"], ["老大", "小二", "贼三"]]
        vc.dataSource = [["老大", "小二", "贼三"]]
        let config = GANormalizePickerViewConfig()
        config.title = "标 题"
        vc.config = config
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func showDate(_ sender: Any) {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let vc = ZHDatePickerViewController(nibName: "ZHDatePickerViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            tag, model in
            print(tag, model ?? "model = nil")
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func selectedDate(_ sender: Any) {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let vc = ZHDataPickerViewController(nibName: "ZHDataPickerViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            tag, model in
            print(tag, model ?? "model = nil")
        }
        vc.dataSource = [["2018", "2019", "2020"], ["年"], ["1", "2", "3"], ["月"], ["1", "2", "3", "4"], ["日"], ["2018", "2019", "2020"], ["年"], ["1", "2", "3"], ["月"], ["1", "2", "3", "4"], ["日"]]
        let config = GANormalizePickerViewConfig()
        config.title = "开始时间"
        vc.config = config
        self.present(vc, animated: true, completion: nil)
    }
    
    
}



