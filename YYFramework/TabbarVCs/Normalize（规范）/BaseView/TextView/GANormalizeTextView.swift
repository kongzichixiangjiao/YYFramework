//
//  GANormalizeTextView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/14.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

@objc
protocol GANormalizeTextViewDelegate: class {
    // 编辑change
    @objc optional func normalizeTextViewDidChange(textView: GANormalizeTextView)
    // placehold
    @objc optional func normalizeTextViewPlaceholdView(textView: GANormalizeTextView) -> UIView
    // 内容偏移
    @objc optional func normalizeTextViewContentOffset(textView: GANormalizeTextView) -> UIEdgeInsets
    // 光标位置 更改之后 光标位置不动
    @objc optional func normalizeTextViewCursorPosition(textView: GANormalizeTextView) -> CGRect
    // 点击return按钮
    @objc optional func normalizeTextViewClickedReturn(textView: GANormalizeTextView)
    // 正则筛选字符
    @objc optional func normalizeTextViewRegularString(textView: GANormalizeTextView) -> String
    
}

open class GANormalizeTextView: UITextView {
    
    weak var mDelegate: GANormalizeTextViewDelegate? {
        didSet {
            _initViews()
        }
    }
    
    // 直接给text赋值不走textViewDidChange代理方法
    public var mText: String = "" {
        didSet {
            self.text = mText
            _updatePlaceholderView(t: self)
            _limitTextLength()
            mDelegate?.normalizeTextViewDidChange?(textView: self)
        }
    }
    
    // tintColor
    @IBInspectable var mTintColor: UIColor = UIColor.black
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
    
    private var _placeholderView: UIView? = nil
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        
        self.tintColor = self.mTintColor
    }
    
    convenience public init(frame: CGRect) {
        self.init(frame: frame, textContainer: nil)
        
        self.delegate = self
        
        self.tintColor = self.mTintColor
    }
    
    open override func caretRect(for position: UITextPosition) -> CGRect {
        let rect = super.caretRect(for: position)
        guard let newRect = mDelegate?.normalizeTextViewCursorPosition?(textView: self) else {
            return rect
        }
        return newRect
    }
    
    private func _initViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        _initContentOffset()
        _initPlaceholderView()
    }
    
    private func _initContentOffset() {
        guard let offset = mDelegate?.normalizeTextViewContentOffset?(textView: self) else {
            #if DEBUG
            print("GANormalizeTextView 没有在代理这是偏移量")
            #endif
            return
        }
        self.textContainerInset = UIEdgeInsets(top: offset.top, left: offset.left, bottom: offset.bottom, right: offset.right)
    }
    
    private func _initPlaceholderView() {
        if _placeholderView == nil {
            guard let placeholderView = mDelegate?.normalizeTextViewPlaceholdView?(textView: self) else {
                #if DEBUG
                print("GANormalizeTextView placeholderView == nil 注意：mDelegate和normalizeTextViewPlaceholdView方法")
                #endif
                return
            }
            placeholderView.frame = CGRect(x: self.textContainerInset.left + 4, y: self.textContainerInset.top - 2, width: self.frame.size.width - (self.textContainerInset.left + 2), height: placeholderView.frame.size.height)
            _placeholderView = placeholderView
            self.addSubview(_placeholderView!)
        }
    }
    
    private func _updatePlaceholderView(t: UITextView) {
        _placeholderView?.isHidden = !t.text.isEmpty
    }
    
    private func _delete() {
        
    }
}

extension GANormalizeTextView: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        _updatePlaceholderView(t: textView)
        _limitTextLength()
        mDelegate?.normalizeTextViewDidChange?(textView: self)
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // delete
        if text == "" {
            return true
        }
        
        // return
        if text == "\n" {
            #if DEBUG
            print("GANormalizeTextView text == ", text)
            #endif
            mDelegate?.normalizeTextViewClickedReturn?(textView: self)
            return !(textView.returnKeyType == .done)
        }
        
        // regular
        if !filterRegularString.isEmpty {
            return _judgeRegular(string: text, regularString: filterRegularString)
        }
        if let regular = mDelegate?.normalizeTextViewRegularString?(textView: self) {
            if !regular.isEmpty {
                return _judgeRegular(string: text, regularString: regular)
            }
        }
        
        // only
        if mRemoveSpecialChar {
            return !_judgeSpecialChar(string: text)
        }
        if mOnlyNumber {
            return _judgeNumbser(string: text)
        }
        if mOnlyChineseChar {
            return _judgeChineseChar(string: text)
        }
        if mOnlyLetter {
            return _judgeLetter(string: text)
        }
        if mOnlyLetterOrNumber {
            return _judgeLetterAndNumber(string: text)
        }
        
        return true
    }
    
}

extension GANormalizeTextView: GANormalizeTextEditRegulayProtocol {
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

extension GANormalizeTextView: GANormalizeTextEditMaxCountProtocol {
    func _limitTextLength() {
        guard let _: UITextRange = self.markedTextRange else{
            if self.text!.count > mMaxCount {
                self.text = _subString(to: mMaxCount)
            }
            return
        }
    }
    
    func _subString(to: Int) -> String {
        let text: String = self.text
//        let endIndex = String.Index.init(encodedOffset: to)
        let endIndex = String.Index.init(utf16Offset: to, in: text)
        let subStr = text[text.startIndex..<endIndex]
        return String(subStr)
    }
}

