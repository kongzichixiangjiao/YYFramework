//
//  GAWebViewPreviewViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/1.
//  Copyright © 2019 houjianan. All rights reserved.
//  资源预览

import UIKit

import UIKit
import WebKit

class GAWebViewPreviewViewController: UIViewController {
    
    var webView: DWKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = DWKWebView(frame: self.view.bounds)
//        let url = Bundle.main.url(forResource: "test", withExtension: "xlsx")
//        let url = Bundle.main.url(forResource: "test", withExtension: "pptx")
//        let url = URL(string: "http://pvfrpu5n5.bkt.clouddn.com/test.xlsx")
//        let url = URL(string: "http://pvfrpu5n5.bkt.clouddn.com/test.pptx")
        let url = URL(string: "https://fastdfs.puxinasset.com/group1/M01/00/00/CgMFal1AU8mASZymAGcwANrqfow496.ppt")
//        let url = URL(string: "https://fastdfs.puxinasset.com/group1/M01/00/00/CgMFa11AThKAYasEAAD6AN9oHMo402.xls")

        self.view.addSubview(webView)
        let request = URLRequest.init(url: url!)
        webView.load(request)
        
        
    }
    
    
}



