//
//  GAPickerViewController.swift
//  Need
//
//  Created by houjianan on 2020/3/19.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class GAPickerViewController: YYPresentationBaseViewController {

    @IBOutlet weak var bgView: UIView!
    var dataSource: [[String]] = []
    var kPickerViewHeight: CGFloat = 40 * 5
    let topViewHeight: CGFloat = 35
    @IBOutlet weak var bgViewBottomSpace: NSLayoutConstraint!
    
    lazy var pickerView: GAPickerView = {
        let v = GAPickerView(frame: CGRect(x: 0, y: self.topViewHeight, width: self.bgView.bounds.width, height: kPickerViewHeight), dataSource: self.dataSource, configModel: nil)
        v.tag = 20200318
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        show(dataSource: dataSource)
        isTapBack = true 
    }

    @IBAction func confirmA(_ sender: Any) {
        clickedHandler?(1, pickerView.resultData)
        dismiss()
    }
    
    func show(dataSource: [[String]]) {
        self.dataSource = dataSource
        self.bgView.addSubview(pickerView)
        self.bgViewBottomSpace.constant = self.safeBottomHeight()
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hide() {
        self.bgViewBottomSpace.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }

    func safeBottomHeight() -> CGFloat {
        if #available(iOS 11.0, *) {
            guard let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
                return 0
            }
            return safeAreaInsets.bottom
        } else {
            return 0
        }
    }
}

protocol GAPickerViewProtocol {
    
}

extension GAPickerViewProtocol where Self: UIViewController {
    func pickerNormalView_show(dataSource: [[String]], confirmHandler: @escaping ([String]) -> ()) {
        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: "000000".color0X(0.6))
        let vc = GAPickerViewController(nibName: "GAPickerViewController", bundle: nil, delegate: d)
        vc.dataSource = dataSource
        vc.clickedHandler = {
            tag, model in
            if tag == 1 {
                confirmHandler(model as! [String])
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
}
