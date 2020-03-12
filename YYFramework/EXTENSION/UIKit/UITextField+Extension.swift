//
//  UIselfield+Extension.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/20.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

extension UITextField {
    
    func ga_changeselfiledPlaceHolderColor(colors:UIColor) -> Void {
        // 占位符字体颜色
//        self.setValue(colors, forKeyPath: "_placeholderLabel.textColor")
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : colors])
    }
    
    func ga_changeselfiledPlaceHolderFont(fonts:UIFont) -> Void {
        // 占位符字体大小
        self.setValue(fonts, forKeyPath: "_placeholderLabel.font")
    }
    
    func ga_writeMustChinese() {
        //非markedText才继续往下处理
        guard let _: UITextRange = self.markedTextRange else {
            //当前光标的位置（后面会对其做修改）
            let cursorPostion = self.offset(from: self.endOfDocument, to: self.selectedTextRange!.end)
            //判断非中文的正则表达式
            let pattern = "[^\\u4E00-\\u9FA5]"
            //替换后的字符串（过滤调非中文字符） // yy_pregReplaceYYRegular
            
            let regex = try! NSRegularExpression(pattern: pattern, options: [])
            let str = regex.stringByReplacingMatches(in: self.text!, options: [],
                                                     range: NSMakeRange(0, self.text!.count),
                                                     withTemplate: "")
            self.text = str
            
            //让光标停留在正确位置
            let targetPostion = self.position(from: self.endOfDocument, offset: cursorPostion)!
            self.selectedTextRange = self.textRange(from: targetPostion, to: targetPostion)
            // 最多输入4个汉字
            self.text = String((self.text?.prefix(4))!)
            return
        }
    }
    
}

