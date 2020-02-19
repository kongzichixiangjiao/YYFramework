//
//  GARegular.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/10.
//  Copyright © 2017年 houjianan. All rights reserved.
//  正则表达式 正则判定 用户名 e_mail 手机号 链接 ip html
//  高亮html文案 富文本

import Foundation

enum Regular: String {
    case userName = "^[a-z0-9_-]{3,16}$",
    eMail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}",
    phone = "^1[0-9]{10}$",
    url = "^(https?://)?([da-z.-]+).([a-z.]{2,6})([/w.-]*)*/?$",
    ip = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",
    html = "^<([a-z]+)([^<]+)*(?:>(.*)</1>|s+/>)$",
    ID = "^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$",
    ChineseCharacters = "[^\\u4E00-\\u9FA5]", // 汉字
    letter = "^[A-Za-z0-9]+$", // 字母
    none = ""
}

class GARegular {
    static func ga_match(_ input: String, _ regular: String = "", regularEnum: Regular = .none) -> Bool {
        
        let regular = regularEnum == .none ? regular : regularEnum.rawValue
        
        let regex = try? NSRegularExpression(pattern: regular, options: .caseInsensitive)
        if let matches = regex?.matches(in: input,
                                        options: [],
                                        range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
    
    static func ga_match1(_ input: String, _ regular: String = "", regularEnum: Regular = .none) -> [NSTextCheckingResult] {
        
        let regular = regularEnum == .none ? regular : regularEnum.rawValue
        
        let regex = try? NSRegularExpression(pattern: regular, options: .caseInsensitive)
        if let matches = regex?.matches(in: input,
                                        options: [],
                                        range: NSMakeRange(0, (input as NSString).length)) {
            return matches
        } else{
            return []
        }
    }
}

/*
 var s = "性感<font color='#71bd9c'>和</font>我是加入<font color='#71bd9c'>感性</font>里<font color='#71bd9c'>都有</font>他<font color='#71bd9c'>的</font>影子"
 print(s.filterFontHTML())
 */

extension String {
    // 1 返回字数
    var ga_count: Int {
        let string_NS = self as NSString
        return string_NS.length
    }
    
    //使用正则表达式替换
    func ga_pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        if pattern.isEmpty {
            return ""
        }
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    func ga_filterHTML() -> String {
        var string = ""
        let scanner = Scanner(string: self)
        var text = ""
        let textPoint = AutoreleasingUnsafeMutablePointer<NSString?>(&text)
        while !scanner.isAtEnd {
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo(">", into: textPoint)
            string = self.replacingOccurrences(of: text, with: "123")
        }
        return string
    }
    
    mutating func ga_filterFontHTML() -> String {
        var ss: String = self
        var newS = ""
        let regular = "<font color='#[a-f0-9]{6}'>(.*?)</font>"
        var ranges = [NSRange]()
        var strings = [String]()
        
        var bo: Bool = true
        while bo {
            for i in 0..<GARegular.ga_match1(ss, regular).count {
                if i == 0 {
                    let result = GARegular.ga_match1(ss, regular)[0]
                    let range = result.range
                    ranges.append(range)
                    let endSlicingIndex = ss.index(ss.startIndex, offsetBy: range.location == 0 ? range.length : range.location)
                    let end = ss[endSlicingIndex...]
                    ss = String(end)
                    let newS = self.ga_pregReplace(pattern: ss, with: "")
                    self = ss
                    strings.append(newS)
                }
            }
            if GARegular.ga_match1(ss, regular).count == 0 {
                strings.append(self)
                bo = false
            }
        }
        
        for i in 0..<strings.count {
            var s = strings[i]
            print(s)
            if !GARegular.ga_match(s, regular) {
                s = "<font color=\'#000000\'>"+s+"</font>"
            }
            newS += s
        }
        return newS
    }
    
}

