//
//  GAMaiDianViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/1.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAMaiDianViewController: GANavViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "埋点")
    }
    
    // 添加界面
    @IBAction func addPage(_ sender: Any) {
        PXMD.share.md_pageStart(code: "p001", name: "Page——A")
        PXMD.share.md_pageEnd(code: "p001", name: "Page——A")
    }
    
    // 添加点击事件
    @IBAction func addAction(_ sender: Any) {
        PXMD.share.md_event(code: "e001", name: "登录", page: self.ga_nameOfClass, describe: "埋点界面测试点击事件", widgetType: .button, event: .click)
    }
    
    // 存
    @IBAction func cunAction(_ sender: Any) {
        GAPlistManager.share.writeDicPlist(data: ["1":"2", "33" : "333"], fileName: kPXMDFileName) { (b) in
            print("退出后台/或者杀死App 保存是否成功？", b)
        }
    }
    
    // 取
    @IBAction func quAction(_ sender: Any) {
        let pxmd = GAPlistManager.share.readDicPlist(fileName: kPXMDFileName)
        print(pxmd ?? ["":""])
    }
    
}
