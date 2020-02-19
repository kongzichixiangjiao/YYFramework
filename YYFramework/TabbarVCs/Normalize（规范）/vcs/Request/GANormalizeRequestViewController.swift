//
//  GANormalizeRequestViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/19.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import CryptoSwift

class GANormalizeRequestViewController: UIViewController {
    
    @IBOutlet weak var contentView: UITextView!
    
    @IBAction func post(_ sender: UIButton) {
        
//        let headers = ["pid": "pid", "platform": "11.3999996185303", "clientId": "", "appName": "普信财富", "model": "iPhone", "imei": "", "registrationId": "", "sign": "", "mac": "", "screenSize": "(0.0, 0.0, 375.0, 667.0)", "Token": "", "packageName": "com.puxin.finance", "os": "ios", "factory": "apple", "version": "2.0.3.22", "channel": "appStore"]
//
//        PXRequest.sharePX.requestPX(baseUrlType: ZHUrlType.url, zhUrlApi: .newDiscoverindex, method: .post, parameters: headers, successHandler: { (model) in
//            print(model.result ?? "-")
//            self.contentView.text = model.resultDic.ga_toJSONString()
//        }) { (error, code) in
//            print(error, code)
//        }
        
        
        let AppKey = "e6f78d2ca7dd220c0e390ee553959b67"
        
        let Secret = "f2cbb51158d2"
        let Nonce = String.ga_randomNums(count: 108)
        let CurTime = String(GADate.getStamp())
        
        let CheckSum = (Secret + Nonce + CurTime).sha1()
//      let CheckSum = ga_hexStringFromString(s: (Secret + Nonce + CurTime).sha1())
        
        let header = ["AppKey":AppKey, "Nonce":Nonce, "CurTime":CurTime, "CheckSum":CheckSum]
        print(header)
        let _ = ZHReuqest.share.request(baseUrlType: .url, zhUrlApi: ZHRequestApi.IM.rawValue, method: .post, parameters: ["accid":"abc13A14aeq", "mobile":"13146218617"], headers: header, successHandler: { (model) in
//            print(model.message)
//            print(model.resultDic)
        }) { (error, errorCode) in
            print(error, errorCode)
        }
        
    }
    
    
    func ga_hexStringFromString(s: String) -> String {
        let myD = s.data(using: .utf8)
        let bytes = myD?.bytes
        var hexString = ""
        for i in 0..<bytes!.count {
            let newHexStr = String(format: "%x", bytes![i]&0xff)
            if newHexStr.length == 1 {
                hexString = hexString + "0" + newHexStr
            } else {
                hexString = hexString + newHexStr
            }
        }
        return hexString
    }
    
    func hexStringFormData(s: String) -> String {
        let data = s.data(using: .utf8)
        return NSString.init(format: "%@", data! as NSData).replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
    }
    
    // 2 - 10
    func binary2dec(num:String) -> Int {
        let nums = String(num.filter { num.contains($0) })
        var sum = 0
        for c in nums {
            print(c)
            sum = sum * 2 + Int("\\(c)")!
        }
        return sum
    }
    // 10 - 16
    // String(15,radix:16)
    //将十六进制字符串转化为 Data
    func data(from hexStr: String) -> Data {
        let bytes = self.bytes(from: hexStr)
        return Data(bytes)
    }
    
    // 将16进制字符串转化为 [UInt8]
    // 使用的时候直接初始化出 Data
    // Data(bytes: Array)
    func bytes(from hexStr: String) -> [UInt8] {
        assert(hexStr.count % 2 == 0, "输入字符串格式不对，8位代表一个字符")
        var bytes = [UInt8]()
        var sum = 0
        // 整形的 utf8 编码范围
        let intRange = 48...57
        // 小写 a~f 的 utf8 的编码范围
        let lowercaseRange = 97...102
        // 大写 A~F 的 utf8 的编码范围
        let uppercasedRange = 65...70
        for (index, c) in hexStr.utf8CString.enumerated() {
            var intC = Int(c.byteSwapped)
            if intC == 0 {
                break
            } else if intRange.contains(intC) {
                intC -= 48
            } else if lowercaseRange.contains(intC) {
                intC -= 87
            } else if uppercasedRange.contains(intC) {
                intC -= 55
            } else {
                assertionFailure("输入字符串格式不对，每个字符都需要在0~9，a~f，A~F内")
            }
            sum = sum * 16 + intC
            // 每两个十六进制字母代表8位，即一个字节
            if index % 2 != 0 {
                bytes.append(UInt8(sum))
                sum = 0
            }
        }
        return bytes
    }
    
    
    @IBAction func cancle(_ sender: Any) {
        PXRequest.sharePX.cancleAllRequests()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension NSData {
    
    /// Create hexadecimal string representation of `Data` object.
    ///
    /// - returns: `String` representation of this `Data` object.
    
    func hexadecimal() -> String {
        var string = ""
        var byte: UInt8 = 0
        
        for i in 0 ..< length {
            getBytes(&byte, range: NSMakeRange(i, 1))
            string += String(format: "%02x", byte)
        }
        
        return string
    }
}
