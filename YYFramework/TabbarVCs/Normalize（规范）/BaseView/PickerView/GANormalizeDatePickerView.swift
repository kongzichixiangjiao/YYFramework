//
//  PXDatePickerView.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

public enum GANormalizeDatePickerViewType: Int {
    case none = 0, cancle = 1, confirm = 2
}

open class GANormalizeDatePickerView: UIView {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleLabel: UILabel!
    
    public var datePickerMode: UIDatePicker.Mode = .date {
        didSet {
            datePicker.datePickerMode = datePickerMode
        }
    }
    public var dateFormatString: String = "yyyy-MM-dd"
    public var titleString: String = "" {
        didSet {
            titleLabel.text = titleString
        }
    }
    
    public var type: GANormalizeDatePickerViewType = .none
    
    typealias DatePickerViewClickedHandler = (_ date: Date?, _ countDownDuration: TimeInterval?, _ type: GANormalizeDatePickerViewType) -> ()
    var datePickerViewClickedHandler: DatePickerViewClickedHandler?
    
    static func loadDatePickerView() -> GANormalizeDatePickerView {
        return Bundle.main.loadNibNamed("GANormalizeDatePickerView", owner: nil, options: nil)?.last as! GANormalizeDatePickerView
    }
    
    @IBAction func cancleAction(_ sender: UIButton) {
        datePickerViewClickedHandler?(nil, nil, .cancle)
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        if datePickerMode == .countDownTimer {
            datePickerViewClickedHandler?(nil, datePicker.countDownDuration, .confirm)
        } else {
            datePickerViewClickedHandler?(datePicker.date, nil, .confirm)
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        _initBottomLineView()
        self.backgroundColor = UIColor.randomColor()
    }
    
    // 分割线
    var _isShowBottomLineView: Bool = true
    var _marginSpaceBottomLineView: CGFloat = 16
    lazy var _bottomLineView: UIView = {
        let v = UIView()
        v.backgroundColor = kSeptalLine_1_LevelColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private func _initBottomLineView() {
        if _isShowBottomLineView {
            self.addSubview(_bottomLineView)
            
            self.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 44))
            self.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: _marginSpaceBottomLineView))
            self.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -_marginSpaceBottomLineView))
            _bottomLineView.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 1.0 / UIScreen.main.scale))
        }
    }
}
