//
//  JsApiTestSwift.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/21.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

typealias JSCallback = (String,Bool) -> Void

class JsApiTestSwift: NSObject {
    var valueCount: Int?
    var timer: Timer?
    var handler: JSCallback?
    
    @objc func testSyn(_ msg: String) -> String {
        return String(format:"%@[Swift sync call:%@]", msg, "test")
    }
    
    // 1、@objc
    // 2、_
    // 3、NSArray 跪谢我向阳大哥
    @objc func testAsyn(_ msg: String, handler: NSArray) {
        if let handler = handler.firstObject as? JSCallback {
            handler(String(format:"%@[Swift async call:%@]", msg, "test"), true)
        }
    }
    
    @objc func testNoArgSyn(_ args: [String : Any]) -> String {
        return "testNoArgSyn called [ syn call]"
    }
    
    @objc func testNoArgAsyn(_ args: [String : Any], _ handler: NSArray) {
        if let handler = handler.firstObject as? JSCallback {
            handler("testNoArgAsyn called [ asyn call]", true)
        }
    }
    
    @objc func callProgress(_ args: [String : Any], _ completionHandler: @escaping JSCallback) {
        valueCount = 10
        handler = completionHandler
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
    }
    
    @objc func onTimer() {
        if (valueCount! != -1) {
            self.valueCount! -= 1
            handler!((String(describing: valueCount)), false)
        } else {
            handler!("0", true)
            timer?.invalidate()
        }
    }
    @objc func zhTransformUserInfor(_ msg: String) -> String {
        return ["a":"1"].ga_toJSONString()!
    }
    
    @objc func zhTransformUserInfors(_ msg: String, _ handlers: NSArray){
        if let handler = handlers.firstObject as? JSCallback {
            handler(["a":"1"].ga_toJSONString()!, true)
        }
    }
    
    @objc func zh_telephoneCall(_ msg: String) {
        print(msg)
    }
    
    
    @objc func getCustomerEva(_ msg: String) {
        print(msg)
    }
    
    @objc func openingResult(_ msg: String) {
        print(msg)
    }
    
    
}

class JsApiTest: NSObject {
    
    var valueCount: Int?
    var timer: Timer?
    var handler: JSCallback?
    
    @objc func testSyn(_ msg: String) -> String {
        return msg + "[ syn call]"
    }
    
    @objc func testAsyn(_ msg: String, _ handlers: NSArray) {
        if let handler = handlers.firstObject as? JSCallback {
            handler(msg + " [ asyn call]", true)
        }
    }
    
    @objc func testNoArgSyn(_ args: [String : Any]) -> String {
        return "testNoArgSyn called [ syn call]"
    }
    
    @objc func testNoArgAsyn(_ args: [String : Any], _ handlers: NSArray) {
        if let handler = handlers.firstObject as? JSCallback {
            handler("testNoArgAsyn called [ asyn call]", true)
        }
    }
    
    @objc func callProgress(_ args: [String : Any], _ handlers: NSArray) {
        if let handlerItem = handlers.firstObject as? JSCallback {
            valueCount = 10
            handler = handlerItem
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func onTimer() {
        if (valueCount! != -1) {
            self.valueCount! -= 1
            handler!(String(valueCount!), false)
        } else {
            handler!("0", true)
            timer?.invalidate()
        }
    }
    
    @objc func zhTransformUserInfor(_ msg: String) -> String {
        return ["a":"1"].ga_toJSONString()!
    }
    
    @objc func zhTransformUserInfors(_ msg: String, _ handlers: NSArray){
        if let handler = handlers.firstObject as? JSCallback {
            handler(["a":"1"].ga_toJSONString()!, true)
        }
    }

}

class JsEchoApi: NSObject {
    @objc func syn(_ msg: Any) -> Any {
        return msg
    }
    
    @objc func asyn(_ arg: [String : Any], _ handlers: NSArray) {
        if let handlerItem = handlers.firstObject as? JSCallback {
//            handlerItem(arg.ga_toJSONString() ?? "arg.ga_toJSONString() nil", true)
            handlerItem("echo api", true)
        }
    }
}
