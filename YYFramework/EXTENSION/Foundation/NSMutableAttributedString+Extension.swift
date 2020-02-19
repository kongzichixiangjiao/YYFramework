//
//  NSMutableAttributedString+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//
/*
 *  富文本编辑
 *  高亮字体
 */

import UIKit

extension NSAttributedString {
    
    static func yy_paragraphStyle() -> NSMutableParagraphStyle {
        let style                 = NSMutableParagraphStyle()
        style.lineSpacing         = 5.0 //每行文字之间的距离
        style.paragraphSpacing    = 5.0 //段落之间的距离
        style.headIndent          = 0.0 //每一行前面缩进的距离
        style.firstLineHeadIndent = 0.0 //每段开头缩进
        return style
    }
    
    static func yy_contentStyle(_ text: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        let style = yy_paragraphStyle()
        attributed.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: NSMakeRange(0, attributed.length))
        return attributed
    }

    // 字符串中有高亮字体 方法一：
    static func yy_highLightSubstring(allString: String, subString: String, color: UIColor) -> NSMutableAttributedString {
        let arr = allString.components(separatedBy: subString)
        let newMAttributed = NSMutableAttributedString()
        for i in 0..<arr.count {
            let s = arr[i]
            if !s.isEmpty {
                let attributed = NSAttributedString(string: s)
                newMAttributed.append(attributed)
            }
            
            if i != arr.count - 1 {
                let subMAttributed = NSMutableAttributedString(string: subString)
                subMAttributed.addAttributes([NSAttributedString.Key.foregroundColor : color], range: NSMakeRange(0, subMAttributed.length))
                
                newMAttributed.append(subMAttributed)
            }
        }
        
        return newMAttributed
    }
    // 方法二：
    /*
    do {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attString = try NSMutableAttributedString(data: model.introduce.data(using: String.Encoding.unicode)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        attString.addAttributes([NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15)], range: NSMakeRange(0, attString.length))
        attString.addAttributes([NSAttributedStringKey.paragraphStyle : style], range: NSMakeRange(0, attString.length))
        describeLabel.attributedText = attString
    } catch {
        describeLabel.text = model.introduce
    }
 */
}
