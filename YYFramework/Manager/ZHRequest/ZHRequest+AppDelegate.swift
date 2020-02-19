//
//  ZHRequest+AppDelegate.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/1.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation
import Alamofire

extension AppDelegate {
    struct AppDelegateKey {
        static var kNetWorkManager: UInt = 20180717
    }
    
    var zh_netWorkManager: NetworkReachabilityManager {
        set {
            objc_setAssociatedObject(self, &AppDelegateKey.kNetWorkManager, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let n = objc_getAssociatedObject(self, &AppDelegateKey.kNetWorkManager)  else {
                return NetworkReachabilityManager(host: "www.baidu.com")!
            }
            return n as! NetworkReachabilityManager
        }
    }
    
}

/*
// MARK: rsa 加密
import SwiftyRSA
extension String {
    public func rsa_pem(s: String = "rsa_public_key") -> String {
        let publicKey = try! PublicKey(pemNamed: "s)
        let clear = try! ClearMessage(string: self, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)
        
        let _ = encrypted.data
        let base64String = encrypted.base64String
        
        return base64String
    }
}
*/
