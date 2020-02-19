//
//  GANormalizeTextFeild.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/18.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

@objc
protocol GANormalizeTextFieldDelegate: class {
    // 编辑change
    @objc optional func normalizeTextFieldDidChange(textField: GANormalizeTextField)
    
    // 正则筛选字符
    @objc optional func normalizeTextFieldRegularString(textField: GANormalizeTextField) -> String
    
    // 编辑区域
    @objc optional func normalizeTextFieldEditingRect(textField: GANormalizeTextField) -> CGRect
    
    @objc optional func normalizeTextField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
}

class GANormalizeTextField: UITextField {
    weak var mDelegate: GANormalizeTextFieldDelegate? {
        didSet {
            _addTarget()
            _initPlaceholder()
        }
    }
    
    // 字数输入限制
    @IBInspectable var mMaxCount: Int = 9999
    // 只允许输入数字
    @IBInspectable var mOnlyNumber: Bool = false
    // 只允许输入汉字 ChineseCharacters
    @IBInspectable var mOnlyChineseChar: Bool = false
    // 只允许输入字母
    @IBInspectable var mOnlyLetter: Bool = false
    // 只允许输入字符和数字
    @IBInspectable var mOnlyLetterOrNumber: Bool = false
    // 是否移除特殊字符
    @IBInspectable var mRemoveSpecialChar: Bool = false
    // 自定义正则 筛选字符
    @IBInspectable var filterRegularString: String = ""
    
    @IBInspectable var placeholderTextColor: UIColor?
    @IBInspectable var placeholderFontSize: CGFloat = 14
    
    typealias ChangedHandler = (_ t: UITextField) -> ()
    var _changedHandler: ChangedHandler?
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        
        if mOnlyLetter {
            self.keyboardType = .emailAddress
        }
        if mOnlyNumber {
            self.keyboardType = .numbersAndPunctuation
        }
        if mOnlyLetterOrNumber {
            self.keyboardType = .emailAddress
        }
    }
    
    convenience public init(frame: CGRect, placeholder: String = "", changedHandler: @escaping ChangedHandler) {
        self.init(frame: frame)
        
        self._changedHandler = changedHandler
        
        self.placeholder = placeholder
        self.delegate = self
    }
    
    // 编辑区域位置
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        guard let newRect = mDelegate?.normalizeTextFieldEditingRect?(textField: self) else {
            return rect
        }
        return newRect
    }
    
    // placeholder位置
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.placeholderRect(forBounds: bounds)
        guard let newRect = mDelegate?.normalizeTextFieldEditingRect?(textField: self) else {
            return rect
        }
        return newRect
    }
    
    private func _initPlaceholder()  {
        if let color = placeholderTextColor {
            self.setValue(color, forKeyPath: "_placeholderLabel.textColor")
        }
        let font = UIFont.systemFont(ofSize: placeholderFontSize)
        self.setValue(font, forKeyPath: "_placeholderLabel.font")
    }
    
    private func _addTarget() {
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    var t: String = ""
}

extension GANormalizeTextField: UITextFieldDelegate {
    
    @objc public func textFieldDidChange(_ textField: UITextField) {
        // 输入汉字特殊处理
        if mOnlyLetterOrNumber {
            if let text = textField.text {
                var newText = ""
                for c in text.normalizeTextField_enumChar() {
                    if _judgeChineseChar(string: c.description) {
                        
                    } else {
                        newText += c.description
                    }
                }
                textField.text = newText
            }
        }
        _limitTextLength()
        _changedHandler?(textField)
        mDelegate?.normalizeTextFieldDidChange?(textField: self)
    }
    
    @available(iOS 10.0, *)
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print(reason)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        print(textField.textInputMode?.primaryLanguage)
//        let primaryLanguage = textField.textInputMode?.primaryLanguage
        if let b = mDelegate?.normalizeTextField?(textField, shouldChangeCharactersIn: range, replacementString: string) {
            return b
        }
        
        // delete
        if string == "" {
            return true
        }
        
        // regular
        if !filterRegularString.isEmpty {
            return _judgeRegular(string: string, regularString: filterRegularString)
        }
        if let regular = mDelegate?.normalizeTextFieldRegularString?(textField: self) {
            if !regular.isEmpty {
                return _judgeRegular(string: string, regularString: regular)
            }
        }
        
        // only
        if mRemoveSpecialChar {
            return !_judgeSpecialChar(string: string)
        }
        if mOnlyNumber {
            return _judgeNumbser(string: string)
        }
        if mOnlyChineseChar {
            return _judgeChineseChar(string: string)
        }
        if mOnlyLetter {
            return _judgeLetter(string: string)
        }
        if mOnlyLetterOrNumber {
            return _judgeLetterAndNumber(string: string)
        }
        
        return true
    }
    
}

extension GANormalizeTextField: GANormalizeTextEditRegulayProtocol {
    func _judgeNumbser(string: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: "1234567890").inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        return (string == filtered)
    }
    
    func _judgeLetterAndNumber(string: String) -> Bool {
        return _judgeRegular(string: string, regularString: "[a-zA-Z0-9]")
    }
    
    func _judgeSpecialChar(string: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: "[ _`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]|\n|\r|\t\"]").inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        return (string == filtered)
    }
    
    func _judgeChineseChar(string: String) -> Bool {
        return !_judgeRegular(string: string, regularString: "[^\\u4E00-\\u9FA5]")
    }
    
    func _judgeLetter(string: String) -> Bool {
        return _judgeRegular(string: string, regularString: "[a-zA-Z]")
    }
    
    func _judgeRegular(string: String, regularString: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: regularString, options: .caseInsensitive)
        if let matches = regex?.matches(in: string,
                                        options: [],
                                        range: NSMakeRange(0, (string as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
}

extension GANormalizeTextField: GANormalizeTextEditMaxCountProtocol {
    func _limitTextLength() {
        guard let _: UITextRange = self.markedTextRange else{
            if self.text!.count > mMaxCount {
                self.text = _subString(to: mMaxCount)
            }
            return
        }
    }
    
    func _subString(to: Int) -> String {
        let text: String = self.text!
        let endIndex = String.Index.init(encodedOffset: to)
        let subStr = text[text.startIndex..<endIndex]
        return String(subStr)
    }
}

extension String {
    func normalizeTextField_enumChar() -> [Character] {
        if self.isEmpty {
            return []
        }
        var chars: [Character] = []
        for char in self {
            chars.append(char)
        }
        return chars
    }
}
