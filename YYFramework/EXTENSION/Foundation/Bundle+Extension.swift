//
//  Bundle+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

extension String {
    func yy_path() -> String {
        var arr = self.components(separatedBy: ".")
        if (arr.count == 1) {
            arr.append("plist")
        }
        return Bundle.main.path(forResource: arr.first, ofType: arr.last, inDirectory: nil) ?? ""
    }
}

extension Bundle {
    
    /*
     *  PXAlertOnlyBottomViewController是pod添加的GAAlertPresentation中的xib资源文件
     *  eg:
     *      let bundle = Bundle.ga_podBundle(aClass: PXAlertOnlyBottomViewController.classForCoder(), resource: "GAAlertPresentation")
     */
    static func ga_podBundle(aClass: Swift.AnyClass, resource: String) -> Bundle? {
        let podBundle = Bundle(for: aClass)
        let bundleURL = podBundle.url(forResource: resource, withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)
        return bundle
    }
}
