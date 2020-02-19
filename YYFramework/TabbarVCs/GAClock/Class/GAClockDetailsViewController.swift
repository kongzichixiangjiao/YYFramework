//
//  GAClockDetailsViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/26.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

enum ClockPickerType: String {
    case mRepeat = "重复", bell = "铃声", tag = "标签", title = "标题"
}

protocol GAClockDetailsViewControllerDelegate: class {
    func clockDetailsViewControllerAddPop()
}

class GAClockDetailsViewController: GANavViewController {
    
    weak var delegate: GAClockDetailsViewControllerDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var repeatTypeLabel: UILabel!
    @IBOutlet weak var repeatTypeView: GACustomCellView!
    
    @IBOutlet weak var tagTypeView: GACustomCellView!
    @IBOutlet weak var tagTypeLabel: UILabel!
    
    @IBOutlet weak var bellTypeView: GACustomCellView!
    @IBOutlet weak var bellTypeLabel: UILabel!
    
    @IBOutlet weak var titleTypeView: GACustomCellView!
    @IBOutlet weak var titleTypeLabel: UILabel!
    
    private let pickerData = [ClockPickerType.mRepeat.rawValue : [["星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]], ClockPickerType.bell.rawValue : [["dx07"]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "详")
        b_showNavigationRightButton(title: "保存", imgName: "") { (title) in
            self._save()
        }
        
        _initActions()
    }
    
    private func _save() {
        GALocalPushManager.share.post(fireDate: datePicker.date, repeatInterval: .day, alertTitle: titleTypeLabel.text ?? "", alertBody: tagTypeLabel.text ?? "", soundName: (bellTypeLabel.text ?? "dx07") + ".caf", userInfo: ["key":""])
        delegate?.clockDetailsViewControllerAddPop()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func _initActions() {
        repeatTypeView.didClick = {
            self._showRepeat()
        }
        
        titleTypeView.didClick = {
            self._showTitle()
        }
        
        tagTypeView.didClick = {
            self._showTag()
        }
        
        bellTypeView.didClick = {
            self._showBell()
        }
    }
    
    private func _showBell() {
        let typeString: String = ClockPickerType.bell.rawValue

        let d = YYPresentationDelegate(animationType: .sheet, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let vc = ZHDataPickerViewController(nibName: "ZHDataPickerViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            tag, model in
            self.bellTypeLabel.text = model as? String
        }
        vc.dataSource = pickerData[typeString] ?? [[]]
        let config = GANormalizePickerViewConfig()
        config.title = typeString
        vc.config = config
        self.present(vc, animated: true, completion: nil)
    }
    
    private func _showRepeat() {
        let d = YYPresentationDelegate(animationType: .alert, isShowMaskView: true, maskViewColor: UIColor.randomColor(0.3))
        let vc = GAClockRepeatViewController(nibName: "GAClockRepeatViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            tag, model in
            if tag == 1 {
                self.repeatTypeLabel.text = model as? String
            }
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    private func _showTitle() {
        let vc = GAClockTagViewController(nibName: "GAClockTagViewController", bundle: nil)
        vc.delegate = self
        vc.fromType = .title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func _showTag() {
        let vc = GAClockTagViewController(nibName: "GAClockTagViewController", bundle: nil)
        vc.delegate = self
        vc.fromType = .tag
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension GAClockDetailsViewController: GAClockTagViewControllerDelegate {
    func clockTagViewControllerBack(text: String, type: ClockPickerType) {
        if type == .tag {
            tagTypeLabel.text = text
        } else if type == .title {
            titleTypeLabel.text = text
        } else {
            
        }
    }
}
