//
//  GATagsEditView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/11.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GATagsEditViewDelegate: class {
    func tagsEditViewClickedConfirm(text: String)
}

class GATagsEditViewModel {
    var placeHolder: String = "请输入标签名称，最多6个字"
    var textFieldTextColor = "999999".tagsView_color0X
    var backgroundColor = "FBFBFB".tagsView_color0X
    var fontSize: CGFloat = 11
    
    var btnText: String = "确定"
    var btnTextColor = "FFFFFF".tagsView_color0X
    var btnWidth: CGFloat = 34.0
    var btnNormalIcon: String = "tagsEditView_btn_bg_enable_icon"
    var btnDisabledIcon: String = "tagsEditView_btn_bg_normal_icon"
    var btnFontSize: CGFloat = 11
    
    var maxCount: Int = 6
}

class GATagsEditView: UIView {
    
    weak var delegate: GATagsEditViewDelegate?
    
    var textField: UITextField!
    
    var confirmButton: UIButton!
    private var _m: GATagsEditViewModel = GATagsEditViewModel()
    
    convenience init(frame: CGRect, model: GATagsEditViewModel) {
        self.init(frame: frame)
        
        self._m = model
        
        _initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _initViews() {
        textField = UITextField(frame: CGRect(x: 5, y: 0, width: self.bounds.width, height: self.bounds.height))
        textField.placeholder = _m.placeHolder
        textField.font = UIFont.systemFont(ofSize: _m.fontSize)
        textField.textColor = _m.textFieldTextColor
        textField.backgroundColor = _m.backgroundColor
        textField.addTarget(self, action: #selector(textFieldEditChange(_:)), for: .editingChanged)
        self.addSubview(textField)
        
        let b = UIButton(type: .custom)
        let bW: CGFloat = _m.btnWidth
        b.frame = CGRect(x: self.size.width - bW, y: 0, width: bW, height: self.size.height)
        b.setBackgroundImage(UIImage(named: _m.btnNormalIcon), for: .normal)
        b.setBackgroundImage(UIImage(named: _m.btnDisabledIcon), for: .disabled)
        b.setTitle(_m.btnText, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: _m.btnFontSize)
        b.titleLabel?.textColor = _m.btnTextColor
        b.isEnabled = false
        b.addTarget(self, action: #selector(confirm(_:)), for: .touchUpInside)
        self.addSubview(b)
        confirmButton = b
    }
    
    @objc func confirm(_ b: UIButton) {
        guard let t = textField.text else {
            return
        }
        delegate?.tagsEditViewClickedConfirm(text: t)
        
        textField.resignFirstResponder()
    }
    
    @objc func textFieldEditChange(_ textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        
        _limitTextLength()
        
        confirmButton.isEnabled = !text.isEmpty
    }
}

extension GATagsEditView {
    func _limitTextLength() {
        guard let _: UITextRange = textField.markedTextRange else{
            if textField.text!.count > _m.maxCount {
                textField.text = _subString(to: _m.maxCount)
            }
            return
        }
    }
    
    func _subString(to: Int) -> String {
        let text: String = textField.text ?? ""
//        let endIndex = String.Index.init(encodedOffset: to)
        let endIndex = String.Index.init(utf16Offset: to, in: text)
        let subStr = text[text.startIndex..<endIndex]
        return String(subStr)
    }
}

extension GATagsEditView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.tagsEditViewClickedConfirm(text: textField.text ?? "")
    }
}
