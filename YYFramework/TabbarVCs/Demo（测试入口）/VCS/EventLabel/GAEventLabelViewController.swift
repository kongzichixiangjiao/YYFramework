//
//  GAEventLabelViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/5.
//  Copyright © 2019 houjianan. All rights reserved.
//  富文本协议事件

import UIKit

class GAEventLabelViewController: GAViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let agreeString = "我已阅读并同意我已阅读并同意《服务协议》我已阅读并同意我已阅读并同意"
        let attribute = NSMutableAttributedString(string: agreeString)
    
        let range = NSRange(location: 14, length: 6)
        //设置颜色
        attribute.addAttributes([NSAttributedString.Key.foregroundColor:UIColor.orange], range: range)
        //设置链接
        attribute.addAttributes([NSAttributedString.Key.link:"https://www.baidu.com"], range: range)
        
        let l = UILabel(frame: CGRect(x: 0, y: 100, width: self.view.width, height: 100))
        self.view.addSubview(l)
        l.attributedText = attribute
        
        let t = UITextView(frame: CGRect(x: 0, y: 300, width: 140, height: 100))
        t.backgroundColor = UIColor.lightGray
        self.view.addSubview(t)
        t.attributedText = attribute
        t.delegate = self
        t.isEditable = false
        t.isScrollEnabled = false
        t.linkTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.orange]
        
    }
}

extension GAEventLabelViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        print(URL)
        return false
    }
}

extension NSMutableAttributedString {
    
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
