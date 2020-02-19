//
//  GAInternalApis.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/17.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

class InternalApis: NSObject {
    @objc var webview: DWKWebView!
    
    @objc func hasNativeMethod(_ args: Any?) -> Any {
        if (args == nil) {
            return self.webview.on(message: ["":""], type: .DSB_API_HASNATIVEMETHOD)
        } else {
            return self.webview.on(message: args as! [String : Any], type: .DSB_API_HASNATIVEMETHOD)
        }
    }
    @objc func closePage(_ args: Any?) -> Any {
        if (args == nil) {
            return self.webview.on(message: ["":""], type: .DSB_API_CLOSEPAGE)
        } else {
            return self.webview.on(message: args as! [String : Any], type: .DSB_API_CLOSEPAGE)
        }
    }
    @objc func returnValue(_ args: Any?) -> Any {
        if (args == nil) {
            return self.webview.on(message: ["":""], type: .DSB_API_RETURNVALUE)
        } else {
            return self.webview.on(message: args as! [String : Any], type: .DSB_API_RETURNVALUE)
        }
    }
    @objc func dsinit(_ args: Any?) -> Any {
        if (args == nil) {
            return self.webview.on(message: ["":""], type: .DSB_API_DSINIT)
        } else {
            return self.webview.on(message: args as! [String : Any], type: .DSB_API_DSINIT)
        }
    }
    @objc func disableJavascriptDialogBlock(_ args: Any?) -> Any {
        if (args == nil) {
            return self.webview.on(message: ["":""], type: .DSB_API_DISABLESAFETYALERTBOX)
        } else {
            return self.webview.on(message: args as! [String : Any], type: .DSB_API_DISABLESAFETYALERTBOX)
        }
    }
}
