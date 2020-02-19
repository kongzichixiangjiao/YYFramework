//
//  GAAreaPickerViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/23.
//  Copyright © 2019 houjianan. All rights reserved.
//  地区选择

import UIKit

class GAAreaPickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice.current.systemVersion.floatValue >= 8.0 {
            self.modalPresentationStyle = .overCurrentContext
        } else {
            self.modalPresentationStyle = .currentContext
        }
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        
        self.view.addSubview(areaPickerView)
        
        areaPickerView.resultHandler = {
            [weak self] models in
            if let _ = self {
                print("models = ", models)
            }
        }
        
        areaPickerView.closedHandler = {
            [weak self] in
            if let weakSelf = self {
                weakSelf.dismiss(animated: true, completion: nil)
            }
        }
        
        // 重新配置数据
//        areaPickerView.hotData = [["regionCode":"110100","regionName":"北京市","parentId":"110000"]]
//        areaPickerView.dataSource = [["":""]]
    }
    
    lazy var areaPickerView: GAAreaPickerView = {
        let v = GAAreaPickerView.loadView()
        v.frame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: self.view.bounds.height - 200)
        return v
    }()

}
