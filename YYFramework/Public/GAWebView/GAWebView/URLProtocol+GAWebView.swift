//
//  GAWebView+URLProtocol.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/9.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import WebKit

extension URLProtocol {
    static func ga_register(scheme: String) {
        let cls = NSClassFromString("WKBrowsingContextController") as AnyObject
        let sel = NSSelectorFromString("registerSchemeForCustomProtocol:")
        
        if (cls.responds(to: sel)) {
            let _ = cls.perform(sel, with: scheme)
        }
    }
    
        static func ga_unregister(scheme: String) {
            let cls = NSClassFromString("WKBrowsingContextController") as AnyObject
            let sel = NSSelectorFromString("unregisterSchemeForCustomProtocol:")
            
            if (cls.responds(to: sel)) {
                let _ = cls.perform(sel, with: scheme)
            }
        }
}


class GAURLProtocol: URLProtocol, URLSessionDelegate {
    
    var mTask: URLSessionTask!
    
    override class func canInit(with request: URLRequest) -> Bool {
        let scheme = request.url?.scheme
        if scheme?.caseInsensitiveCompare("http") == .orderedSame || scheme?.caseInsensitiveCompare("https") == .orderedSame {
            if ((URLProtocol.property(forKey: "GAURLProtocol", in: request)) != nil) {
                return false
            }
            return true
        }
        return false
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        var requetNew = request
        if request.url?.absoluteString == "" {
            let url = URL(string: "")
            requetNew = URLRequest(url: url!)
        }
        return requetNew
    }
    
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(a, to: b)
    }
    
    override func startLoading() {
        let requestNew = request
        URLProtocol.setProperty(true, forKey: "GAURLProtocol", in: request as! NSMutableURLRequest)
        
        if requestNew.url?.absoluteString == "" {
            print("---")
        } else {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
            mTask = session.dataTask(with: self.request, completionHandler: { (data, response, error) in
                print(data ?? "", response ?? "", error ?? "")
            })
            mTask.resume()
        }
    }
    
    override func stopLoading() {
        if self.mTask != nil {
            self.mTask?.cancel()
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .allowed)
        completionHandler(.allow)
    }

    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        client?.urlProtocol(self, didLoad: data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        client?.urlProtocolDidFinishLoading(self)
    }


}

