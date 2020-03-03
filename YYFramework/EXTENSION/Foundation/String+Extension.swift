//
//  String+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//
/*
 * 1、计算字符串长度、宽度；
 * 2、sha1加密 md5加密
 * 3、urlEncode  localized
 * 4、16进制字符串转颜色
 * 5、字符串转URL
 * 6、字符在字符串中的位置
 * 7、字符串初始化xib view
 * 8、String -> UIStoryboard   String -> XIB
 * 9、字符串转CGFloat 转Double
 * 10、字符串格式化 ****   eg：13146218617 -> 1314***8617
 * 11、字符串截取相关方法
 */

import UIKit
import Foundation

// MARK: 计算宽度
extension String {
    func ga_widthWith(_ fontSize: CGFloat, height: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func ga_heightWith(_ fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func ga_heightWith(_ fontSize: CGFloat, width: CGFloat, style: NSParagraphStyle) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle : style], context: nil)
        return ceil(rect.height)
    }
}


// #import <CommonCrypto/CommonCrypto.h>
// MARK: SHA1  MD5
extension String {
    //sha1加密算法
    var sha1: String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        CC_SHA1((data as NSData).bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
    }
    
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deallocate()
        
        return String(format: hash as String)
    }
}

// MARK: urlEncode  localized
extension String {
    var urlEncode: String! {
        let cs = NSCharacterSet(charactersIn:"!*'();:@&=+$,/?%#[]").inverted
        return self.addingPercentEncoding(withAllowedCharacters: cs)
    }
    
    var urlDecode: String! {
        let cs = NSCharacterSet.alphanumerics
        let encodePath = self.addingPercentEncoding(withAllowedCharacters: cs)
        return encodePath?.removingPercentEncoding
    }
    
    var localized: String! {
        return NSLocalizedString(self, comment: "")
    }
    
    var UTF8String: String! {
        let d = Data(base64Encoded: self)
        let newS = String(data: d!, encoding: .utf8)
        return newS
    }
}

// WARK: base64f编码、解码
extension String {
    func ga_base64Encoding() -> String {
        let plainData = self.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    
    func ga_base64Decoding() -> String {
        let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedString
    }
}

// WARK: COLOR
extension String {
    var color0X: UIColor! {
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
    
    func color0X(_ alpha: CGFloat) -> UIColor {
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
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
}

// MARK: String -> URL
extension String {
    var ga_url: URL? {
        if let u = URL(string: self) {
            if self != "" {
                return u
            }
            return nil
        }
        return nil
    }
}

extension String {
    var ga_string_url: URL? {
        if let u = URL(string: self) {
            if self != "" {
                return u
            }
            return nil
        }
        return nil
    }
    
    var ga_file_url: URL {
        return URL(fileURLWithPath: self)
    }
}

// MARK: positionOf(_ sub: String)
extension String {
    func yy_positionOf(_ sub: String) -> Int {
        var pos = -1
        if let range = range(of:sub) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    func yy_rangeOf(_ sub: String) -> Range<String.Index> {
        return self.range(of: sub)!
    }
}

// MARK: xibLoadView()
extension String {
    func xibLoadView() -> UIView {
        return Bundle.main.loadNibNamed(self, owner: nil, options: nil)?.last as! UIView
    }
}

// MARK: String -> Float   String -> Double
extension String {
    // Float字符串 -> Float
    func toFloat() -> Float? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.floatValue
    }
    
    // Float字符串 -> CGFloat
    func ga_toCGFloat(digits: Int) -> CGFloat? {
        let arr = self.components(separatedBy: ".")
        var s: String = (arr.first ?? "0") + "."
        s = s + String((arr.last ?? "").prefix(digits))
        return CGFloat(s.toDouble()!)
    }
    
    // Float字符串 -> 保留指定位数的Float字符串
    func ga_toFloat(digits: Int) -> String {
        let arr = self.components(separatedBy: ".")
        var s: String = (arr.first ?? "0") + "."
        s = s + String((arr.last ?? "").prefix(digits))
        return s
    }
    
    // String -> Double
    func toDouble() -> Double? {
        let numberFormatter = NumberFormatter()
        return numberFormatter.number(from: self)?.doubleValue
    }
}

// MARK: String -> UIStoryboard   String -> XIB
extension String {
    func yy_storyboard() -> UIStoryboard {
        return UIStoryboard(name: self, bundle: nil)
    }
    
    func yy_xib() -> UIViewController {
        return UIViewController(nibName: self, bundle: nil)
    }
}

// MARK: 字符串格式化***
extension String {
    // preCount 前面保留个数
    // sufCount: 后面保留个数
    // starCount: *个数
    func ga_formattingStar(preCount: Int, sufCount: Int, starCount: Int, symbol: String = "*") -> String {
        
        if self.isEmpty {
            return self
        }
        if self.count < preCount || self.count < sufCount {
            print("ga_formattingStar - error")
            return self
        }
        if preCount + sufCount > self.count {
            print("ga_formattingStar - error")
            return self
        }
        
        let preIndex = self.index(self.startIndex, offsetBy: preCount)
        var preString = self.prefix(upTo: preIndex)
        //        print(preString)
        let sufIndex = self.index(self.endIndex, offsetBy: -sufCount)
        let sufString = self.suffix(from: sufIndex)
        //        print(sufString)
        for _ in 0..<starCount {
            preString += symbol
        }
        //        print(String(preString + sufString))
        return String(preString + sufString)
    }
}

// MARK: 
extension String {
    
    var ga_length: Int {
        return self.count
    }
    
    var length: Int {
        return self.count
    }
    
    func ga_prefix(maxLength: Int) -> String {
        return String(self.prefix(maxLength))
    }
    
    func ga_suffix(maxLength: Int) -> String {
        return String(self.suffix(maxLength))
    }
    
    // 将数组中的字符串拼接
    func ga_joined(strings: [String]) -> String {
        return strings.joined(separator: self)
    }
    
    func ga_enumChar() -> [Character] {
        if self.isEmpty {
            return []
        }
        var chars: [Character] = []
        for char in self {
            chars.append(char)
        }
        return chars
    }
    // 去除字符串两端的空白字符
    func ga_trimSpace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    func ga_indexOf(_ target: String) -> Int? {
        return target.endIndex.utf16Offset(in: target)
//        return self.firstIndex(of: target)?.encodedOffset
//        return self.firstIndex(of: target)?.utf16Offset(in: .utf)
    }
    
    func ga_subString(to: Int) -> String {
//        let endIndex = String.Index.init(encodedOffset: to)
        let endIndex = String.Index.init(utf16Offset: to, in: self)
        let subStr = self[self.startIndex..<endIndex]
        return String(subStr)
    }
    
    func ga_subString(from: Int) -> String {
        if self.isEmpty || from < 0 {
            return ""
        }
        if from > self.count {
            print("WARNING.... ga_subString (from > self.count)")
            return self
        }
//        let startIndex = String.Index.init(encodedOffset: from)
        let startIndex = String.Index.init(utf16Offset: from, in: self)
        let subStr = self[startIndex..<self.endIndex]
        return String(subStr)
    }
    
    func ga_sliceString(start: Int, end: Int) -> String {
        return ga_sliceString((start...end))
    }
    
    func ga_subString(range: Range<String.Index>) -> String {
        return String(self[range.lowerBound..<range.upperBound])
    }
    
    // 切割字符串(区间范围 (区间范围 前闭后开) )
    func ga_sliceString(_ range:CountableRange<Int>) -> String{
        guard
            let startIndex = ga_validStartIndex(original: range.lowerBound),
            let endIndex = ga_validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        
        return String(self[startIndex..<endIndex])
    }
    
    // 切割字符串(区间范围 (区间范围 前闭后闭) )
    func ga_sliceString(_ range:CountableClosedRange<Int>) -> String {
        guard
            let start_Index = ga_validStartIndex(original: range.lowerBound),
            let end_Index = ga_validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        if(endIndex.utf16Offset(in: self) <= end_Index.utf16Offset(in: self)){
//        if(endIndex.encodedOffset <= end_Index.encodedOffset){
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
    }
    
    // 校验字符串位置是否合理
    func ga_validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.utf16Offset(in: self):
            return startIndex
        case endIndex.utf16Offset(in: self)...:
            return endIndex
        default:
            return index(startIndex, offsetBy: original)
        }
//        switch original {
//        case ...startIndex.encodedOffset:
//            return startIndex
//        case endIndex.encodedOffset...:
//            return endIndex
//        default:
//            return index(startIndex, offsetBy: original)
//        }
    }
    // 校验是否是合法的起始位置
    func ga_validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.utf16Offset(in: self) else { return nil }
        return ga_validIndex(original:original)
    }
    // 校验是否是合法的结束位置
    func ga_validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.utf16Offset(in: self) else { return nil }
        return ga_validIndex(original:original)
    }
    
}

// MARK: 生成随机字符串
extension String {
    
    /// 生成随机字符串
    ///
    /// - Parameters:
    ///   - count: 生成字符串长度
    ///   - isLetter: false=大小写字母和数字组成，true=大小写字母组成，默认为false
    /// - Returns: String
    static func ga_random(_ count: Int, _ isLetter: Bool = false) -> String {
        
        var ch: [CChar] = Array(repeating: 0, count: count)
        for index in 0..<count {
            
            var num = isLetter ? arc4random_uniform(58)+65:arc4random_uniform(75)+48
            if num>57 && num<65 && isLetter==false { num = num%57+48 }
            else if num>90 && num<97 { num = num%90+65 }
            
            ch[index] = CChar(num)
        }
        
        return String(cString: ch)
    }
    
    static func ga_randomNums(count: Int) -> String {
        let m = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "a", "b", "c", "d", "e", "f"]
        //获取一个随机整数范围在：[0,100)包括0，不包括100

        var nums: [String] = []
        for _ in 0..<count {
            let x: Int = Int(arc4random() % 10)
            nums.append(m[x])
        }
        return nums.joined(separator: "")
    }
}

// MARK: 版本号判断
extension String {
    static func ga_hasNewVersionCompare(old: String, new: String) -> Bool {
        if old.compare(new, options: String.CompareOptions.numeric) == .orderedAscending {
            #if DEBUG
            print("有新版本")
            #endif
            return true
        } else if old.compare(new, options: String.CompareOptions.numeric) == .orderedSame {
            #if DEBUG
            print("当前版本")
            #endif
            return false
        } else {
            #if DEBUG
            print("无新版本")
            #endif
            return false
        }
    }
}

// MARK: 获取IP
extension String {
    public var ipAddress: String {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first ?? "0.0.0.0"
    }
}

// MARK: 中文->字母 获取中文首字母
extension String {
    // 是否是汉字
    func ga_isIncludeChinese() -> Bool {
        for ch in self.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) { return true } // 中文字符范围：0x4e00 ~ 0x9fff
        }
        return false
    }
    
    /// 将中文字符串转换为拼音
    ///
    /// - Parameter hasBlank: 是否带空格（默认不带空格）
    func ga_transformToPinyin(hasBlank: Bool = false) -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return hasBlank ? pinyin : pinyin.replacingOccurrences(of: " ", with: "")
    }
    
    /// 获取中文首字母
    ///
    /// - Parameter lowercased: 是否小写（默认大写）
    func ga_transformToPinyinHead(lowercased: Bool = false) -> String {
        let pinyin = self.ga_transformToPinyin(hasBlank: true).capitalized // 字符串转换为首字母大写
        var headPinyinStr = ""
        for ch in pinyin.ga_enumChar() {
            if ch <= "Z" && ch >= "A" {
                headPinyinStr.append(ch) // 获取所有大写字母
            }
        }
        return lowercased ? headPinyinStr.lowercased() : headPinyinStr
    }
    
}

