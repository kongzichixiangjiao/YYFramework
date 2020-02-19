
//
//  YYWebView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  WKWebView

import UIKit
import WebKit
import JavaScriptCore
import HandyJSON

protocol GAWebViewDelegate: NSObjectProtocol {
    func ga_webViewDidFinish(_ height: CGFloat)
}

class GAWebView: UIView {
    
    private let kEstimatedProgress = "estimatedProgress"
    private let kWebViewTitle = "title"
    private let kJS_Name = "AppModel"
    
    weak var myDelegate: GAWebViewDelegate?
    
    var jsContext: JSContext!
    
    public var jsStrings: [String] = []
    public var url: String!
    public var fileName: String!
    public var progressViewHeight: CGFloat = 2
    
    public var isShowProgress: Bool? {
        didSet {
            if isShowProgress! {
                self.insertSubview(progressView, at: 100)
                webView.addObserver(self, forKeyPath: kEstimatedProgress, options: .new, context: nil)
            }
        }
    }
    
    func jsAAA() {
        webView.evaluateJavaScript("") { (obj, error) in
            
        }
    }
    
    lazy var configuration: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        // 设置偏好设置
        config.preferences = WKPreferences()
        // 默认为0
        config.preferences.minimumFontSize = 10
        // 默认认为YES
        config.preferences.javaScriptEnabled = true
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        // web内容处理池
        //         config.processPool = WKProcessPool()
        config.userContentController = self.userContentController
        // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
        // 我们可以在WKScriptMessageHandler代理中接收到
//        config.userContentController.add(self, name: kJS_Name)
        config.userContentController.add(WeakScriptMessageDelegate(self), name: kJS_Name)
        
        return config
    }()
    
    // 通过JS与webview内容交互
    lazy var userContentController: WKUserContentController = {
        let c = WKUserContentController()
        return c
    }()
    
    
    lazy var progressView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: progressViewHeight, width: self.webView.frame.size.width, height: progressViewHeight))
        v.backgroundColor = UIColor.blue
        return v
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: self.frame, configuration: self.configuration)
        // 开启侧边手势
        webView.allowsBackForwardNavigationGestures = true
        //        webView.rev
        // 3DTouch
        webView.allowsLinkPreview = true
        webView.uiDelegate = self
        webView.navigationDelegate = self

        /*
         webView.perform(Selector("_setApplicationNameForUserAgent:"), with: "My App User Agent addition")
         webView.customUserAgent = ""
         webView.setValue("customUserAgent", forKey: "applicationNameForUserAgent")
        */
        
        self.addSubview(webView)
        return webView
    }()
    
    private func _addCooie() {
        let s = WKUserScript(source: "document.cookie = 'DarkAngelCookie=DarkAngel;'", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
        self.userContentController.addUserScript(s)
    }
    
    private func _addJS(jsString: String) {
        /*
         注入的js source可以是任何js字符串，也可以js文件。比如你有很多提供给h5使用的js方法，那么你本地可能就会有一个native_functions.js，你可以通过以下的方式添加
         //防止频繁IO操作，造成性能影响
         static NSString *jsSource;
         static dispatch_once_t onceToken;
         dispatch_once(&onceToken, ^{
         jsSource = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"native_functions" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
         });
         //添加自定义的脚本
         WKUserScript *js = [[WKUserScript alloc] initWithSource:jsSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
         [self.configuration.userContentController addUserScript:js];
         */
        /*
         注入js方法 js文件需要实现
        let s = WKUserScript(source: "alert(document.cookie);", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        self.userContentController.addUserScript(s)
         */
//        let s = WKUserScript(source: "jsAction();", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
//        self.userContentController.addUserScript(s)
//        let s1 = WKUserScript(source: "callSyn1();", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
//        self.userContentController.addUserScript(s1)
        let s2 = WKUserScript(source: "window._dswk=true;", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        self.userContentController.addUserScript(s2)
        let s3 = WKUserScript(source: "{\"callbackId\":0,\"method\":\"addValue\",\"data\":\"[3,4]\"}", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        self.userContentController.addUserScript(s3)
        
        let s4 = WKUserScript(source: "bridge.register(0,addValue,[3,4])", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        self.userContentController.addUserScript(s4)
        
        // 添加js调用native方法
//        self.userContentController.add(WeakScriptMessageDelegate(self), name: jsString)
        self.userContentController.add(WeakScriptMessageDelegate(self), name: "bridge.register(0,addValue,[3,4])")
        
    }
    
    private func _loadFileReuqest() {
        if fileName.isEmpty {
            self.showView("error - fileName isEmpty")
            return
        }
        let url = Bundle.main.url(forResource: fileName, withExtension: "html")
        let request = URLRequest(url: url!, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30)
        if #available(iOS 11, *) {
            webView.load(request)
        }else{
            let request = NSMutableURLRequest.init(url: url!, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30)
            request.httpMethod = "GET"
            //                request.httpBody = ("token=" + tokenValue()).data(using: String.Encoding.utf8)
            webView.load(request as URLRequest)
        }
    }

    /*
    public enum CachePolicy : UInt {
        // 默认策略，具体的缓存逻辑和协议的声明有关，如果协议没有声明，不需要每次重新验证cache。
        case useProtocolCachePolicy
        // 忽略本地缓存，直接从后台请求数据
        case reloadIgnoringLocalCacheData
        //  系统未实现，忽略本地缓存数据、代理和其他中介的缓存，直接从后台请求数据
        case reloadIgnoringLocalAndRemoteCacheData
        public static var reloadIgnoringCacheData: NSURLRequest.CachePolicy { get }
        // 优先从本地拿数据，且忽略请求生命时长和过期时间。但是如果没有本地cache，则请求源数据
        case returnCacheDataElseLoad
        //只从本地拿数据
        case returnCacheDataDontLoad
        //  未实现 从原始地址确认缓存数据的合法性后，缓存数据就可以使用，否则从原始地址加载。
        case reloadRevalidatingCacheData
    }
 */
    private func _loadUrlReuqest() {
        if url.isEmpty {
            self.showView("error - url isEmpty")
            return
        }
        let request = URLRequest(url: self.url.ga_url!, cachePolicy: NSURLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 30)
        webView.load(request)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        webView.addObserver(self, forKeyPath: kWebViewTitle, options: .new, context: nil)
    }
    
    convenience init(frame: CGRect, url: String = "", fileName: String = "") {
        self.init(frame: frame)
        if !url.isEmpty {
            self.url = url
            _loadUrlReuqest()
        }
        if !fileName.isEmpty {
            self.fileName = fileName
            _loadFileReuqest()
        }
    }
    
    public func addJS(jsStrings: [String]) {
        self.jsStrings = jsStrings
        for js in jsStrings {
            _addJS(jsString: js)
        }
    }
    
    public func loading(isShowHUD: Bool = false) {
        if isShowHUD {
            self.ga_showLoading()
        }
        if url != nil && !url.isEmpty {
            _loadUrlReuqest()
        }
        
        if fileName != nil && !fileName.isEmpty {
            _loadFileReuqest()
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == kEstimatedProgress) {
            progressView.frame = CGRect(x: 0, y: 0, width: self.webView.frame.size.width * CGFloat(webView.estimatedProgress), height: progressViewHeight)
        } else if (keyPath == kWebViewTitle) {
            print(self.webView.title ?? "")
        }
    }
    
    // 执行goBack或reload或goToBackForwardListItem后马上执行loadRequest，即一起执行，在didFailProvisionalNavigation方法中会报错，error.code = -999（ NSURLErrorCancelled）。
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
        /// 延迟加载新的url，否则报错-999
        
        self.perform(#selector(performLoadRequest), with: nil, afterDelay: 0.5)
    }
    
    @objc func performLoadRequest() {
        return
        //        webView.load(URLRequest())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func ga_webViewDeinit() {
        guard let progress = isShowProgress else {
            return
        }
        if progress {
            webView.removeObserver(self, forKeyPath: kEstimatedProgress)
        }
        webView.removeObserver(self, forKeyPath: kWebViewTitle)

        // 对应userContentController.add(self, name: kJS_Name)
        webView.configuration.userContentController.removeScriptMessageHandler(forName: kJS_Name)
    }
    
    deinit {
        guard let progress = isShowProgress else {
            return
        }
        if progress {
            removeObserver(webView, forKeyPath: kEstimatedProgress)
        }
        removeObserver(webView, forKeyPath: kWebViewTitle)
        
        // 对应userContentController.add(self, name: kJS_Name)
        webView.configuration.userContentController.removeScriptMessageHandler(forName: kJS_Name)
    }
    
}

extension GAWebView: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    // 开始加载时
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progressView.isHidden = false
    }
    
    // 内容开始返回时
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    // 页面加载完成时
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if self.webView.frame.height > self.frame.height {
            self.myDelegate?.ga_webViewDidFinish(self.webView.frame.height)
        }
        
        iosCallJS(webView, didFinish: navigation)
        
        if !webView.isLoading {
            self.ga_hideLoading()
            self.progressView.isHidden = true
        }
    }
    
    private func iosCallJS(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("iOSCallJsAlert('我是ios过来的值')", completionHandler: nil)
        webView.evaluateJavaScript("call(1, 2)", completionHandler: nil)

        webView.evaluateJavaScript("window._handleMessageFromNative({\"callbackId\":2,\"method\":\"addValue\",\"data\":\"[3,4]\"})", completionHandler: nil)
        let dic = ["callbackId" : 4, "method" : "syn.getInfo", "data" : "[]"] as [String : Any]
        let dicString = dic.ga_toJSONString()

        let scriptString = "window._handleMessageFromNative(" + dicString! + ")"
        _ = scriptString.replacingOccurrences(of: "\"", with: "\\\"")
        webView.evaluateJavaScript(scriptString, completionHandler: nil)
        
    }
    
    // 页面加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    // <a href="tel:13222223333”>打电话</a>
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        let scheme = url?.scheme
        guard let schemeStr = scheme else { return  }
        if schemeStr == "tel" {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [UIApplication.OpenExternalURLOptionsKey : Any](), completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }
    
    /* JS传值给iOS */
    /*
     js代码：window.webkit.messageHandlers.currentCookies.postMessage(document.cookie);
     */
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.name)
        print(message.body)
        if (message.name == kJS_Name) {
            // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull类型
            print(message.body)
        }
    }
    /*
     在JS端调用alert函数时(警告弹窗)，会触发此代理方法。
     通过completionHandler()回调JS
     */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        self.showView(message)
        completionHandler()
        /*
         let alertController:UIAlertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
         alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
         completionHandler()
         }))
         self.present(alertController, animated: true) {
         
         }
         */
    }
    /*
     JS端调用confirm函数时(确认、取消式弹窗)，会触发此方法
     completionHandler(true)返回结果
     */
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        self.showView(message)
        completionHandler(true)
        /*
         let alertController:UIAlertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
         alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
         completionHandler(true)
         }))
         alertController.addAction(UIAlertAction(title: "取消", style: .default, handler: { (action) in
         completionHandler(false)
         }))
         self.present(alertController, animated: true) {
         
         }
         */
    }
    /*
     JS调用prompt函数(输入框)时回调，completionHandler回调结果
     */
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        //        self.showView(prompt)
//        print(prompt)
        // 接收值
//        print(defaultText ?? "--")

        let m = mo.deserialize(from: defaultText)
        print(m?.data ?? "")
//        if m?.data != nil {
//            print(m?.data as! [String : Any])
//        }
        // 返回值
        completionHandler("^_^")
        /*
         let alertController:UIAlertController = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
         alertController.addTextField { (textField) in
         textField.text = defaultText
         }
         alertController.addAction(UIAlertAction(title: "完成", style: .default, handler: { (action) in
         completionHandler(alertController.textFields?.first?.text)
         }))
         */
    }
}

class mo: HandyJSON {
    var data: Any?
    
    required init() {
        
    }
}
