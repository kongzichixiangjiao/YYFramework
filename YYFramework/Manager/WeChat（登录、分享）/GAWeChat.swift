//
//  GAWeChat.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/9/25.
//  Copyright © 2019 houjianan. All rights reserved.
//  企业微信登录

/*
 GAWeChat.share.login(successHandler: { (token) in
 print("登陆成功，token = ", token)
 }) { (type) in
 switch type {
 case .cancle:
 print("点击取消")
 break
 case .sendFinished:
 print("发送完成")
 break
 case .error:
 print("登录失败 的操作")
 break
 case .otherError: break
 }
 }
 
 001、URL Type
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
 <key>CFBundleTypeRole</key>
 <string>Editor</string>
 <key>CFBundleURLName</key>
 <string>main</string>
 <key>CFBundleURLSchemes</key>
 <array>
 <string>wwauthf6cf118e6ad2bedf000018</string>
 </array>
 </dict>
 </plist>
 002、
 企业微信corpId wwf6cf118e6ad2bedf
 选择“企业微信授权登录”，在设置界面填写iOS App的Bundleid，设置完成后系统自动生成应用程序schema。
 1000018 门户测试
 需要创建对应的应用
 */

import Foundation

enum GAWeChatFinishedType: Int {
    case sendFinished = 1, error = 2, cancle = 3, otherError = 4
}

enum GAWeChatRegisterType: Int {
    case wx = 0, qywx = 1
}

class GAWeChat: NSObject {
    
    static let share: GAWeChat = GAWeChat()
    typealias SuccessHandler = (_ token: Any) -> ()
    typealias FinishedHandler = (_ type: GAWeChatFinishedType) -> ()
    var successHandler: SuccessHandler?
    var fishedHandler: FinishedHandler?
    
    private let _wwHundleId = "com.tencent.ww"
    
    func register() {
        WWKApi.registerApp("wwauthf6cf118e6ad2bedf000018", corpId: "wwf6cf118e6ad2bedf", agentId: "1000018")
    }
    
    func login(successHandler: @escaping SuccessHandler, fishedHandler: @escaping FinishedHandler) {
        let req = WWKSSOReq()
        req.state = "aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz0123456789"
        WWKApi.send(req)
        
        self.successHandler = successHandler
        self.fishedHandler = fishedHandler
        
        self.fishedHandler?(.sendFinished)
    }
    
    func hanleOpen(url: URL, sourse: String) -> Bool {
        return WWKApi.handleOpen(url, delegate: self)
    }
    
}

// MARK:  企业微信 WWKApiDelegate
extension GAWeChat: WWKApiDelegate {
    func onResp(_ resp: WWKBaseResp!) {
        if resp.bundleID == _wwHundleId {
            if resp.errStr == "OK" {
                if resp.wx_nameOfClass == "WWKSSOResp" {
                    _WWKSSOResp(resp: resp)
                }
            } else if resp.errStr == "cancelled" {
                self.fishedHandler?(.cancle)
            } else if resp.errStr == "Failed" {
                self.fishedHandler?(.otherError)
            } else {
                self.fishedHandler?(.otherError)
            }
        }
    }
    
    private func _WWKSSOResp(resp: WWKBaseResp) {
        if resp.errCode == 0 && resp.bundleID == _wwHundleId {
            guard let result = resp.serializedDict else {
                #if DEBUG
                print("登录失败")
                #endif
                self.fishedHandler?(.error)
                return
            }
            guard let errCode = result["errCode"] as? Int, let token = result["sso.code"] else {
                #if DEBUG
                print("登录失败")
                #endif
                self.fishedHandler?(.error)
                return
            }
            if errCode == 0 {
                #if DEBUG
                print("登录成功, token = ", token)
                #endif
                self.successHandler?(token)
            }
        }
    }
}

class GAWXLib: NSObject {
    static let share: GAWXLib = GAWXLib()
    typealias SuccessHandler = (_ token: Any) -> ()
    typealias FinishedHandler = (_ type: GAWeChatFinishedType) -> ()
    var successHandler: SuccessHandler?
    var fishedHandler: FinishedHandler?
    
    private let _wwHundleId = "com.tencent.ww"
    
    func register() {
        // universalLink 暂时时候金服准生产环境域名
        // 后台配置 apple-app-site-association（全局搜索可查看） 后台给一个地址https://jfapp.puxinzichan.com/apple-app-site-association
        // 微信开发者平台-管理引用-对应应用的开发信息填写universalLink：https://jfapp.puxinzichan.com
        // 项目开启 小地球Associated Domains 添加：applinks:jfapp.puxinzichan.com
        WXApi.registerApp("wx56a2b2b630dd4ce5", universalLink: "https://jfapp.puxinzichan.com")
    }
    
    // 不要忘记 在 “info”标签栏的“LSApplicationQueriesSchemes“添加weixin 和weixinULAPI
    // 否则报错："This app is not allowed to query for scheme weixinulapi"
    func login(vc: UIViewController, successHandler: @escaping SuccessHandler, fishedHandler: @escaping FinishedHandler) {
        if WXApi.isWXAppInstalled() {
            let req = SendAuthReq()
            req.scope = "snsapi_userinfo"
            req.state = "puxinzichan"
            WXApi.send(req) { (finished) in
                print(finished)
            }
        }
        self.successHandler = successHandler
        self.fishedHandler = fishedHandler
    }
    
    func handleOpenUniversalLink(userActivity: NSUserActivity) -> Bool {
        let b = WXApi.handleOpenUniversalLink(userActivity, delegate: self)
        return b
    }
}

// MARK:  微信 WXApiDelegate
extension GAWXLib: WXApiDelegate {
    func onReq(_ req: BaseReq) {
        
    }
    
    func onResp(_ resp: BaseResp) {
        let r = (resp as! SendAuthResp)
        print(r.type)
        print(r.errCode)
        print(r.errStr)
        
        if r.type == 0 && r.errCode == 0 {
            #if DEBUG
            print("登录成功")
            #endif
            self.successHandler?(r.code ?? "")
        } else {
            #if DEBUG
            print("登录失败")
            #endif
            self.fishedHandler?(.error)
        }
    }
}

// MARK: wx_nameOfClass
extension NSObject {
    var wx_nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

