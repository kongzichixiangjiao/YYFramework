//
//  ZHPickerViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/20.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

open class ZHDataPickerViewController: YYPresentationBaseViewController {

    public var kPickerViewHeigh: CGFloat = 200
    public var dataSource: [[String]] = [[String]]()
    public var config: GANormalizePickerViewConfig = GANormalizePickerViewConfig()
    
    lazy var pickerView: GANormalizePickerView = {
        let v = GANormalizePickerView.loadPickerView()
        v.frame = CGRect(x: 0, y: self.view.frame.height - kPickerViewHeigh, width: self.view.width, height: kPickerViewHeigh)
        v.pickerViewDidSelectHandler = self.pickerViewDidSelectHandler
        v.pickerViewMultigroupDidSelectHandler = self.pickerViewMultigroupDidSelectHandler
//        v.mType = .dat_e
//        v.pikcerView.isHidden = true
        self.view.addSubview(v)
        return v
    }()
    
    lazy var pickerViewDidSelectHandler: GANormalizePickerView.PickerViewDidSelectHandler = {
        [weak self] pickerView, r, c, type in
        if let weakSelf = self {
            #if DEBUG
            if weakSelf.dataSource.count > 0 {
                print(weakSelf.dataSource[c][r])
            }
            #endif
            if type == .cancle {
                
            } else {
                weakSelf.clickedHandler?(2, weakSelf.dataSource[c][r])
            }
            weakSelf.dismiss(animated: true, completion: nil)
        }
    }
    
    lazy var pickerViewMultigroupDidSelectHandler: GANormalizePickerView.PickerViewMultigroupDidSelectHandler = {
        [weak self] pickerView, data, type in
        if let weakSelf = self {
            #if DEBUG
            print(data)
            #endif
            if type == .cancle {
                
            } else {
                
            }
            weakSelf.dismiss(animated: true, completion: nil)
        }
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        isTapBack = true
        
        pickerView.dataSource = dataSource
        pickerView.config = config
        pickerView.reload(type: .none)
    }

    deinit {
        print("ZHPickerViewController - deinit")
    }
}
