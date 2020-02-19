//
//  GARuntimeViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/18.
//  Copyright © 2020 houjianan. All rights reserved.
//  运行时基本使用

import UIKit

class GARuntimeViewController: GANavViewController {
    
    @IBOutlet weak var resultTextView: GANormalizeTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "运行时基本使用002")
        resultTextView.mDelegate = self
    }
    
    @IBAction func getClassProperty(_ sender: Any) {
        let arr = global_getClassProperty(cls: GARuntimeModel.self)
        #if DEBUG
        print("oc: == ", arr)
        resultTextView.mText = resultTextView.mText + arr.ga_jsonString + "\n"
        #endif
        
        let arr1 = global_getClassIvar(cls: GARuntimeModel.self)
        #if DEBUG
        print("oc: arr1 == ", arr1)
        resultTextView.mText = resultTextView.mText + arr1.ga_jsonString + "\n"
        #endif
        
        let arrSwift = global_getClassProperty(cls: GARuntimeModelSwift.self)
        #if DEBUG
        print("swift: == ", arrSwift)
        resultTextView.mText = resultTextView.mText + arrSwift.ga_jsonString + "\n"
        #endif
    }
    
    @IBAction func getClassMethod(_ sender: Any) {
        let arr = global_getClassMethod(cls: GARuntimeModel.self)
        #if DEBUG
        print("oc: == ", arr)
//        resultTextView.mText = resultTextView.mText + arr.ga_jsonString + "\n"
        #endif
        
        let arrSwift = global_getClassMethod(cls: GARuntimeModelSwift.self)
        #if DEBUG
//        resultTextView.mText = resultTextView.mText + (arrSwift.ga_toJSON() ?? "") + "\n"
        print("swift: == ", arrSwift)
        #endif
        
    }
    
    
    
}

extension GARuntimeViewController: GANormalizeTextViewDelegate {
    func normalizeTextViewPlaceholdView(textView: GANormalizeTextView) -> UIView {
        let l = UILabel()
        l.frame = CGRect(x: 0, y: 0, width: 100, height: 15)
        l.font = textView.font
        l.textColor = UIColor.white
        l.text = "结果展示位置"
        return l
    }
}

@objcMembers class GARuntimeModel: NSObject {
    var a: String = ""
    var b: String?
    var c: Int! // class_copyPropertyList 获取不到
    var d: Int = -1
    var e: String! {
        didSet {
            print(e ?? "")
        }
    }
    var testA: String = ""
    
    func testA(a: String) {
        
    }
    
    func testB(b: String) {
        
    }
    
    func testC() -> Bool {
        return false
    }
    
    func testD(d: String) -> String {
        return "testD"
    }
    
}

class GARuntimeModelSwift {
    dynamic var a: String = ""
    dynamic var b: String?
    var c: Int! // class_copyPropertyList 获取不到
    var d: Int = -1
    var e: String! {
        didSet {
            print(e ?? "")
        }
    }
    var testA: String = ""
    
    dynamic func testA(a: String) {
        
    }
    
    dynamic func testB(b: String) {
        
    }
    
    func testC() -> Bool {
        return false
    }
    
    func testD(d: String) -> String {
        return "testD"
    }
    
}
