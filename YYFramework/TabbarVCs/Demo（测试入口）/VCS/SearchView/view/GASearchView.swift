//
//  GASearchView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/13.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

@objc protocol GASearchViewDelegate: class {
    @objc optional func searchViewClickedCancle()
    @objc optional func searchViewClickedDress()
    @objc optional func searchViewTextFieldDidChange(t: String)
}

class GASearchView: UIView {
    
    weak var delegate: GASearchViewDelegate?
    
    @IBInspectable var textFieldTextColor: UIColor = "333333".search_color0X
    @IBInspectable var textFieldFontSize: CGFloat = 16
    @IBInspectable var textFieldTintColor: UIColor = "2283DF".search_color0X
    @IBInspectable var placeHolder: String = "小区/写字楼/学校等"
    @IBInspectable var iconGlassName: String = "searchView_icon_glass@2x"
    @IBInspectable var iconArowName: String = "searchView_icon_arow@2x"
    @IBInspectable var dressButtonWidth: CGFloat = 80.0
    @IBInspectable var dressText: String = "北京"
    
    @IBInspectable var isShowCancleButton: Bool = true
    @IBInspectable var bgViewH: CGFloat = 35
    @IBInspectable var textFieldBackViewLeft: CGFloat = 29
    
    @IBInspectable var cancleButtonH: CGFloat = 40
    @IBInspectable var cancleButtonW: CGFloat = 35
    @IBInspectable var cancleButtonLeft: CGFloat = 10
    
    @IBInspectable var marginLeft: CGFloat = 20
    @IBInspectable var marginRight: CGFloat = 15
    
    lazy var cancleButton: UIButton = {
        let v = UIButton(type: .custom)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setTitle("取消", for: .normal)
        v.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        v.setTitleColor("2283DF".search_color0X, for: .normal)
        v.addTarget(self, action: #selector(cancleAction), for: .touchUpInside)
        return v
    }()
    
    lazy var dressButton: UIButton = {
        let v = UIButton()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(clicedDressAction), for: .touchUpInside)
        return v
    }()
    
    lazy var iconArowImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: self.iconArowName)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var dressLabel: UILabel = {
        let v = UILabel()
        v.text = self.dressText
        v.font = UIFont.systemFont(ofSize: 12)
        v.textColor = "333333".edit_color0X
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var textFieldBackView: UIView = {
        let v = UIView()
        v.backgroundColor = "F6F6F6".color0X
        v.layer.cornerRadius = self.bgViewH / 2
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var iconGlassImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: self.iconGlassName)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var textField: UITextField = {
        let v = UITextField(frame: CGRect.zero)
        v.textColor = self.textFieldTextColor
        v.font = UIFont.systemFont(ofSize: self.textFieldFontSize)
        v.placeholder = self.placeHolder
        v.translatesAutoresizingMaskIntoConstraints = false
        v.tintColor = self.textFieldTintColor
        v.delegate = self
        v.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        return v
    }()
    
    @objc func clicedDressAction() {
        delegate?.searchViewClickedDress?()
    }
    
    @objc func cancleAction() {
        delegate?.searchViewClickedCancle?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        _initViews()
    }
    
    private func _initViews() {
        if !isShowCancleButton {
            self.addSubview(dressButton)
            self.search_addLayout(top: 0, left: marginLeft, width: dressButtonWidth - marginLeft, height: bgViewH, item: dressButton, toItem: self)
            
            dressButton.addSubview(iconArowImageView)
            dressButton.search_addLayout(top: nil, bottom: nil, left: nil, right: -11, width: 9, height: 5, centerX: nil, centerY: 0, item: iconArowImageView, toItem: dressButton)
            
            dressButton.addSubview(dressLabel)
            dressButton.search_addLayout(top: nil, bottom: nil, left: nil, right: -20, width: dressButtonWidth - 20 - marginLeft, height: 20, centerX: nil, centerY: 0, item: dressLabel, toItem: dressButton)
        }
        
        self.addSubview(textFieldBackView)
        textFieldBackView.addSubview(textField)
        if isShowCancleButton {
            let w: CGFloat = self.frame.size.width - cancleButtonW - cancleButtonLeft - marginRight - marginLeft
            self.search_addLayout(top: 0, left: marginLeft, width: w, height: bgViewH, item: textFieldBackView, toItem: self)
            
            textFieldBackView.search_addLayout(top: 2, left: textFieldBackViewLeft, width: w - textFieldBackViewLeft, height: bgViewH - 2, item: textField, toItem: textFieldBackView)
        } else {
            let w: CGFloat = self.frame.size.width - dressButtonWidth - marginRight
            self.search_addLayout(top: 0, left: dressButtonWidth, width: self.frame.size.width - dressButtonWidth - marginRight, height: bgViewH, item: textFieldBackView, toItem: self)
            
            textFieldBackView.search_addLayout(top: 2, left: textFieldBackViewLeft, width: w - textFieldBackViewLeft, height: bgViewH - 2, item: textField, toItem: textFieldBackView)
        }
        
        textFieldBackView.addSubview(iconGlassImageView)
        textFieldBackView.search_addLayout(top: 11, left: 11, width: 14, height: 14, item: iconGlassImageView, toItem: textFieldBackView)
        
        if isShowCancleButton {
            self.addSubview(cancleButton)
            self.search_addLayout(top: nil, bottom: nil, left: nil, right: -marginRight, width: cancleButtonW, height: bgViewH, centerX: nil, centerY: 0, item: cancleButton, toItem: self)
        }
    }
    
}

extension GASearchView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    @objc public func textFieldDidChange(_ textField: UITextField) {
        delegate?.searchViewTextFieldDidChange?(t: textField.text ?? "")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        return true
    }
}

extension String {
    // 是否是汉字
    func search_isIncludeChinese() -> Bool {
        for ch in self.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) { return true } // 中文字符范围：0x4e00 ~ 0x9fff
        }
        return false
    }
}

extension UIView {
    
    func search_addLayout(top: CGFloat, left: CGFloat, right: CGFloat, height: CGFloat, item: UIView, toItem: UIView) {
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height))
    }
    
    func search_addLayout(top: CGFloat?, bottom: CGFloat?, left: CGFloat?, right: CGFloat?, width: CGFloat?, height: CGFloat?, centerX: CGFloat?, centerY: CGFloat?, item: UIView, toItem: UIView) {
        if let t = top {
            self.addConstraint(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: t))
        }
        if let b = bottom {
            self.addConstraint(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: toItem, attribute: .bottom, multiplier: 1, constant: b))
        }
        if let l = left {
            self.addConstraint(NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: l))
        }
        if let r = right {
            self.addConstraint(NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1, constant: r))
        }
        if let h = height {
            item.addConstraint(NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: h))
        }
        if let w = width {
            item.addConstraint(NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: w))
        }
        if let x = centerX {
            self.addConstraint(NSLayoutConstraint(item: item, attribute: .centerX, relatedBy: .equal, toItem: toItem, attribute: .centerX, multiplier: 1, constant: x))
        }
        if let y = centerY {
            self.addConstraint(NSLayoutConstraint(item: item, attribute: .centerY, relatedBy: .equal, toItem: toItem, attribute: .centerY, multiplier: 1, constant: y))
        }
    }
    
    func search_addLayout(top: CGFloat, left: CGFloat, width: CGFloat, height: CGFloat, item: UIView, toItem: UIView) {
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: top))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: left))
        item.addConstraint(NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width))
        item.addConstraint(NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height))
    }
}
extension String {
    var search_color0X: UIColor! {
        var cString:String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
