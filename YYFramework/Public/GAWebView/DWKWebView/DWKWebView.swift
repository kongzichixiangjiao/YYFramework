//
//  GAWebView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/17.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import WebKit

public class DWKWebView: WKWebView {
    
    weak var DSUIDelegate: WKUIDelegate?
    
    typealias AlertHandler = () -> ()
    typealias ConfirmHandler = (_ isConfirm: Bool) -> ()
    typealias PromptHandler = (_ text: String) -> ()
    typealias JavascriptCloseWindowListener = () -> ()
    typealias CompletionHandler = (_ s: Any) -> ()
    
    var alertHandler: AlertHandler?
    var confirmHandler: ConfirmHandler?
    var promptHandler: PromptHandler?
    var javascriptCloseWindowListener: JavascriptCloseWindowListener?
    
    var dialogType: Int = 0
    var callId: Int = 0
    var jsDialogBlock: Bool = true
    var javaScriptNamespaceInterfaces: [String : NSObject] = [String : NSObject]()
    var handerMap: [String : CompletionHandler] = [String : CompletionHandler]()
    var callInfoList: [DSCallInfo]? = nil
    var dialogTextDic: [String : String] = ["":""]
    var txtName: UITextField?
    var lastCallTime: TimeInterval = 0
    var jsCache: String = ""
    var isPending: Bool = false
    var isDebug: Bool = false
    
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        let script = WKUserScript.init(source: "window._dswk=true;", injectionTime: .atDocumentStart, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(script)
        callInfoList = []
        super.init(frame: frame, configuration: configuration)
        super.uiDelegate = self as WKUIDelegate
        let interalApis = InternalApis()
        interalApis.webview = self
        addJavascript(object: interalApis, namespace: "_dsb")
    }
   
    
    func addJavascript(object: NSObject, namespace: String) {
        javaScriptNamespaceInterfaces[namespace] = object
    }
    
    func removeJavascript(nameSpace: String) {
        javaScriptNamespaceInterfaces.removeValue(forKey: nameSpace)
    }
    
    func customJavascriptDialogLabelTitles(dic: [String: String]) {
        dialogTextDic = dic
    }
    
    func on(message: [String: Any], type: DSB_API_TYPE) -> Any {
        var ret: Any?
        switch type {
        case .DSB_API_HASNATIVEMETHOD:
            ret = hasNativeMethod(args: message)
           break
        case .DSB_API_CLOSEPAGE:
            let _ = closePage(args: message)
            break
        case .DSB_API_RETURNVALUE:
            ret = returnValue(args: message)
            break
        case .DSB_API_DSINIT:
            ret = dsinit(args: message)
            break
        case .DSB_API_DISABLESAFETYALERTBOX:
            disableJavascriptDialogBlock(disable: (message["disable"] as! Bool))
            break
        }
        return ret ?? ""
    }
    
    func hasNativeMethod(args: [String: Any]) -> Bool {
        let s = (args["name"] as! String).trimmingCharacters(in: CharacterSet.whitespaces)
        let nameStr = JSBUtil.parseNamespace(method: s)
        let type = (args["type"] as! String).trimmingCharacters(in: CharacterSet.whitespaces)
        let JavascriptInterfaceObject = javaScriptNamespaceInterfaces[nameStr[0]]
        let syn = JSBUtil.method(argNum: 1, selName: nameStr[1], classItem: JavascriptInterfaceObject!) != nil
        let asyn = JSBUtil.method(argNum: 2, selName: nameStr[1], classItem: JavascriptInterfaceObject!) != nil
        if ("all" == type && (syn || asyn)) || ("asyn" == type && asyn) || ("syn" == type && syn) {
            return true
        } else {
            return false
        }
    }
    
    func closePage(args: [String: Any]) -> Any? {
        if let listener = javascriptCloseWindowListener  {
            listener()
        }
        
        return nil
    }
    
    func returnValue(args: [String: Any]) -> Any? {
        let id = String((args["id"] as! Int))
        if let completionHandler = handerMap[id] {
            completionHandler(args["data"] ?? "")
            
            if (args["complete"] as! Bool) {
                handerMap.removeValue(forKey: String(id))
            }
        }
        
        return nil
    }

    @objc func dsinit(args: [String: Any]) -> Any? {
        dispatchStartupQueue()
        return nil
    }
    
    func disableJavascriptDialogBlock(disable: Bool) {
        jsDialogBlock = !disable
    }
    
    func hasJavascriptMethod(handlerName: String, callBack: @escaping (_ exist: Bool) -> ()) {
        callHandler(methodName: "_hasJavascriptMethod", args: [handlerName]) { (v) in
            if let method = v as? String {
                callBack(method.isEmpty)
                return
            }
            callBack(false)
        }
    }
    
    func setJavascriptCloseWindow(listener: @escaping JavascriptCloseWindowListener) {
        javascriptCloseWindowListener = listener
    }
    
    func load(url: String) {
        let request = URLRequest.init(url: URL(string: url)!)
        self.load(request)
    }

    func callHandler(methodName: String, args: [Any] = [], completionHandler: (CompletionHandler?)) {
        let callInfo = DSCallInfo()
        callInfo.id = callId
        callId += 1
        callInfo.args = args
        callInfo.method = methodName
        let key = String(callInfo.id!)
        
        if completionHandler != nil {
            handerMap[key] = completionHandler
        }
        
        if callInfoList?.count != nil {
            callInfoList?.append(callInfo)
        } else {
            dispatchJavascriptCall(info: callInfo)
        }
    }
    
    func dispatchStartupQueue() {
        guard let list = callInfoList else {
            return
        }
        for info in list {
            dispatchJavascriptCall(info: info)
        }
        callInfoList = nil
    }
    
    func dispatchJavascriptCall(info: DSCallInfo) {
        let dict = ["method" : info.method ?? "", "callbackId" : info.id ?? "", "data" : JSBUtil.objToJsonString(dict: info.args ?? ["":""])] as [String : Any]
        let json = JSBUtil.objToJsonString(dict: dict)
        print("window._handleMessageFromNative(" + json + ")")
        evaluateJavaScript("window._handleMessageFromNative(" + json + ")", completionHandler: nil)
    }
    
    
    func call(method: String, argStr: String) -> String {
        let errorString = "Error! \n Method " + method + " is not invoked, since there is not a implementation for it"
        var methodItem = method
        let nameStr = JSBUtil.parseNamespace(method: method.trimmingCharacters(in: CharacterSet.whitespaces))
        let JavascriptInterfaceObject = javaScriptNamespaceInterfaces[nameStr[0]]
        print(type(of: JavascriptInterfaceObject))
        var result = ["code" : -1, "data" : ""] as [String : Any]
        if JavascriptInterfaceObject == nil {
            print("Js bridge  called, but can't find a corresponded JavascriptObject , please check your code!")
        } else {
            methodItem = nameStr[1]
            let methodOne = JSBUtil.method(argNum: 1, selName: methodItem, classItem: JavascriptInterfaceObject!)
            let methodTwo = JSBUtil.method(argNum: 2, selName: methodItem, classItem: JavascriptInterfaceObject!)
            
            let sel = NSSelectorFromString(methodOne ?? "")
            let selasyn = NSSelectorFromString(methodTwo ?? "")
            
            let args = JSBUtil.jsonStringToObject(jsonString: argStr) as! [String : Any]

            let data = args["data"]

            let _dscbstub = args["_dscbstub"] as? String
            
            if args.count > 0 && _dscbstub != nil {
                if (JavascriptInterfaceObject?.responds(to: selasyn))! {
                    
                    let handler: JSCallback = {
                        value, complete in
                        var del = ""
                        result["code"] = 0
                        result["data"] = value
                        var valueItem = JSBUtil.objToJsonString(dict: result)
                        valueItem = valueItem.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
                        if complete {
                            del = "delete window." + _dscbstub!
                        }

                        let js = "try {" + _dscbstub! + "(JSON.parse(decodeURIComponent(\"" + valueItem + "\")).data);" + del + "; } catch(e){};"
                        let t = Date().timeIntervalSince1970 * 1000
                        self.jsCache = self.jsCache + js
                        if (t-self.lastCallTime<50) {
                            if (!self.isPending) {
                                self.evalJavascript(delay: 50.0)
                                self.isPending = true
                            }
                        } else {
                            self.evalJavascript(delay: 0)
                        }
                    };
                    let _ = JavascriptInterfaceObject?.perform(selasyn, with: data, with: [handler] as NSArray)
                }
            } else if (JavascriptInterfaceObject?.responds(to: sel))! {
                var ret: Unmanaged<AnyObject>!
                if data == nil {
                    ret = JavascriptInterfaceObject?.perform(sel, with: ["":""])
                } else {
                    ret = JavascriptInterfaceObject?.perform(sel, with: data)
                }
                result["code"] = 0
                if ret != nil {
                    result["data"] = ret?.takeUnretainedValue()
                }
            }
            
            var js = errorString.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
            if isDebug {
                js = "window.alert(decodeURIComponent(\"" + js + "\"));"
                self.evaluateJavaScript(js, completionHandler: nil)
            }
        }
        return JSBUtil.objToJsonString(dict: result)
    }

    func evalJavascript(delay: Double) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 3)) {
            if self.jsCache.count != 0 {
                self.evaluateJavaScript(self.jsCache, completionHandler: nil)
                self.isPending = false
                self.jsCache = ""
                self.lastCallTime = Date().timeIntervalSince1970 * 1000
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DWKWebView: WKUIDelegate {
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let prefix = "_dsbridge="
        if prompt.hasPrefix(prefix) {
            let method = prompt.replacingOccurrences(of: prefix, with: "")
            var result = ""

            result = self.call(method: method, argStr: defaultText!)
            completionHandler(result)
        } else {
            if (!jsDialogBlock) {
                completionHandler(nil)
            }
            self.DSUIDelegate?.webView!(webView, runJavaScriptTextInputPanelWithPrompt: prompt, defaultText: defaultText, initiatedByFrame: frame, completionHandler: completionHandler)
        }
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        if !jsDialogBlock {
            completionHandler()
        }
        if let delegate = self.DSUIDelegate {
            delegate.webView!(webView, runJavaScriptAlertPanelWithMessage: message, initiatedByFrame: frame, completionHandler: completionHandler)
        } else {
            self.dialogType = 1
            if jsDialogBlock {
                alertHandler = completionHandler
            }
            print("alert message -- ", message)
            if(dialogType==1 && (alertHandler != nil)){
                alertHandler!()
                alertHandler=nil
            }else if(dialogType==2 && (confirmHandler != nil)){
                confirmHandler!(true)
                confirmHandler=nil
            }else if(dialogType==3 && (promptHandler != nil) && (txtName != nil)) {
                promptHandler!(txtName?.text ?? "")
                promptHandler=nil
                txtName=nil
            }
        }
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        self.DSUIDelegate?.webView!(webView, runJavaScriptConfirmPanelWithMessage: message, initiatedByFrame: frame, completionHandler: completionHandler)
    }
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return self.DSUIDelegate?.webView!(webView, createWebViewWith: configuration, for: navigationAction, windowFeatures: windowFeatures)
    }
    
    public func webViewDidClose(_ webView: WKWebView) {
        self.DSUIDelegate?.webViewDidClose!(webView)
    }
    
    
    @available(iOS 10.0, *)
    public func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
        return (self.DSUIDelegate?.webView!(webView, shouldPreviewElement: elementInfo))!
    }
    
    @available(iOS 10.0, *)
    public func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
        return self.DSUIDelegate?.webView!(webView, previewingViewControllerForElement: elementInfo, defaultActions: previewActions)
    }
    @available(iOS 10.0, *)
    public func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
        self.DSUIDelegate?.webView!(webView, commitPreviewingViewController: previewingViewController)
    }
    
    
}
