//
//  GATitleEditView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/12.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit


class GATitleEditModel {
    var text: String = ""
    var title: String = ""
}

class GATitleEditView: UIView {
    
    @IBInspectable var title: String = ""
    @IBInspectable var titleFontSize: CGFloat = 14
    @IBInspectable var titleTextColor: UIColor = "333333".edit_color0X
    
    @IBInspectable var textFieldTextColor: UIColor = "333333".edit_color0X
    @IBInspectable var textFieldFontSize: CGFloat = 16
    @IBInspectable var textFieldTintColor: UIColor = "2283DF".edit_color0X
    @IBInspectable var placeHolder: String = "未填写"
    @IBInspectable var mMaxCount: Int = 30
    @IBInspectable var mOnlyNumber: Bool = true

    @IBInspectable var lineViewColor: UIColor = "2283DF".edit_color0X
    
    @IBInspectable var lineViewWidth: CGFloat = 100
    @IBInspectable var leftSpace: CGFloat = 37
    @IBInspectable var titleH: CGFloat = 20
    @IBInspectable var titleW: CGFloat = 150
    @IBInspectable var textFieldH: CGFloat = 22
    @IBInspectable var marginTop: CGFloat = 10
    
    var model: GATitleEditModel? {
        didSet {
            titleLabel.text = model!.title
            textField.text = model!.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _initViews()
    }
    
    lazy var titleLabel: UILabel = {
        let v = UILabel(frame: CGRect.zero)
        v.textColor = self.titleTextColor
        v.font = UIFont.systemFont(ofSize: self.titleFontSize)
        v.text = self.title
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
        v.keyboardType = .numbersAndPunctuation
        v.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        return v
    }()
    
    lazy var lineVeiw: UIView = {
        let v = UIView()
        v.backgroundColor = self.lineViewColor
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        return v
    }()
    
    private func _initViews() {
        self.addSubview(titleLabel)
        self.edit_addLayout(top: 0, left: leftSpace, width: titleW, height: titleH, item: titleLabel, toItem: self)
        
        self.addSubview(textField)
        self.edit_addLayout(top: titleH + marginTop, left: leftSpace, width: self.size.width, height: textFieldH, item: textField, toItem: self)
        
        self.addSubview(lineVeiw)
        self.edit_addLayout(top: titleH + textFieldH + marginTop, left: leftSpace, width: lineViewWidth, height: 1, item: lineVeiw, toItem: self)
    }
    
}

extension GATitleEditView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lineVeiw.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let m = model else {
            return
        }
        m.text = textField.text ?? ""
        lineVeiw.isHidden = true
    }
    
    @objc public func textFieldDidChange(_ textField: UITextField) {
        _limitTextLength()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "" {
            return true
        }
        
        if mOnlyNumber {
            return _judgeNumbser(string: string)
        }
        return true
    }
    
    func _judgeNumbser(string: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: "1234567890").inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        return (string == filtered)
    }
    
    func _limitTextLength() {
        guard let _: UITextRange = textField.markedTextRange else {
            if textField.text!.count > mMaxCount {
                textField.text = _subString(to: mMaxCount)
            }
            return
        }
    }
    
    func _subString(to: Int) -> String {
        let text: String = textField.text!
        let endIndex = String.Index.init(encodedOffset: to)
        let subStr = text[text.startIndex..<endIndex]
        return String(subStr)
    }
    
}
