//
//  GAWebViewViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/27.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit
import WebKit

class GAWebViewViewController: UIViewController {

//    lazy var webView: GAWebView = {
//        let webView = GAWebView(frame: self.view.bounds)
//        webView.isShowProgress = true
//        return webView
//    }()
    
    var webView: DWKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let url = "https://www.baidu.com"
//        let url = "http://wtest.zhengheht.com/dsbridge/js-call-native.html"
//        let url = "http://wtest.zhengheht.com/dsbridge/test.html"
//        webView.url = url
//        webView.fileName = "problem"
//        webView.fileName = "test"
//        webView.addJS(jsStrings: ["callSyn1()", "bridge"])
//        webView.addJS(jsStrings: ["callSyn1()"])
//        webView.loading(isShowHUD: true)
//        self.view.addSubview(webView)
        
        
        webView = DWKWebView(frame: self.view.bounds)
        let url1 = Bundle.main.url(forResource: "test", withExtension: "html")
//        let url1 = Bundle.main.url(forResource: "signature", withExtension: "html") // 签名
//        let url1 = URL(string: "https://jfapp.puxinzichan.com/toGrantAuthorization.html")
//        let url1 = URL(string: "http://172.22.43.75:8020/test/signature.html")
//        let url1 = URL(string: "http://172.22.43.75:8080/dist/startEvaluation.html")
//        let url1 = URL(string: "http://172.22.43.75:8080/dist/measurementWealth.html")
        
        self.view.addSubview(webView)
        
//        webView.addJavascript(object: JsApiTest(), namespace: "")
        webView.addJavascript(object: JsApiTestSwift(), namespace: "")
        webView.addJavascript(object: JsEchoApi(), namespace: "echo")
        webView.DSUIDelegate = self as? WKUIDelegate
        webView.navigationDelegate = self as? WKNavigationDelegate
        let request = URLRequest.init(url: url1!)
        webView.load(request)
        
        webView.addObserver(self, forKeyPath: "title", options: [NSKeyValueObservingOptions.new], context: nil)
        
        webView.callHandler(methodName: "addValue", args: [3, 4]) { (value) in
            print(value)
        }
        webView.callHandler(methodName: "append", args: ["I","love","you"]) { (value) in
            print(value)
        }

        webView.callHandler(methodName: "startTimer") { (value) in
            print(value)
        }
        webView.callHandler(methodName: "syn.addValue", args: [5, 6]) { (value) in
            print(value)
        }
        webView.callHandler(methodName: "syn.getInfo") { (value) in
            print(value)
        }
        webView.callHandler(methodName: "asyn.addValue", args: [5, 6]) { (value) in
            print(value)
        }
        webView.callHandler(methodName: "asyn.getInfo") { (value) in
            print(value)
        }
        webView.hasJavascriptMethod(handlerName: "addValue") { (exist) in
            print(exist)
        }
        webView.hasJavascriptMethod(handlerName: "XX") { (exist) in
            print(exist)
        }
        webView.hasJavascriptMethod(handlerName: "asyn.addValue") { (exist) in
            print(exist)
        }
        webView.hasJavascriptMethod(handlerName: "asyn.XX") { (exist) in
            print(exist)
        }
        webView.setJavascriptCloseWindow {
            print("window.close called")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        print("2")
//        self.webView.ga_webViewDeinit()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(webView.title ?? "")
    }
}

