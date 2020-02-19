//
//  ZHCodeStandardViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/15.
//  Copyright © 2019年 houjianan. All rights reserved.
//

/*
 废弃或者替换的类处理方式？
 */
/*
 组件内部使用MVC MVVM MVCS 都可
 项目内使用MVC
 block很难追踪，难以维护，会延长相关对象的生命周期。建议使用delegate
 */

/*
 用 tab，而非 空格
 文件结束时留一空行
 用足够的空行把代码分割成合理的块
 不要在一行结尾留下空白
 千万别在空行留下缩进（control+i）
 删除无用代码
 */

/*
 能用let尽量使用let
 正确使用open public private final
 */
// 注释描述
enum ZHCodeStandardEnum: Int {
    case code = 0 // code无特殊情况 字母小写
    case code1 = 1 // code1
    case code2 = 2  // code2
}

// 创建model里面的参数添加注释
class ZHReuqestDataModel {
    var productName: String = "" // 产品名字
    var personAge: String = "" // 年龄
}

import UIKit

private let kMaxNumCount = 99
// 所有类命名使用ZH开头
class ZHCodeStandardViewController: UIViewController {
    
    private let fileName = "类名-项目名"
    
    static let staticString = ""
    
    public var publicString = "" // ❌public var publicString: String = ""
    // 私有变量_开头
    private var _privateString = ""
    // 常量k开头
    private let kString = "kString"
    
    public var model: ZHCodeStandardModel!
    public var models: [ZHCodeStandardModel] = [] // ❌[ZHCodeStandardModel]()
    public var dic: [String:String] = [:]  // ❌[String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        standardView.frame = CGRect(x: 10, y: 10, width: 10, height: 10)
    }
    
    // MARK: request
    private func _privateRequest() {
        // 请求参数
        let _ = ["a":"b", "c":"d"]
        
        // 请求实例
        
        // 请求成功回调，如果代码行数过多，单独写个方法
        _privateReuqstSuccess()
        
        // 请求失败回调
    }
    
    private func _privateReuqstSuccess(codeEnum: ZHCodeStandardEnum = .code2) {
        // 方法注意空格使用
        
        switch codeEnum {
        case .code:
            break
        case .code1:
            break
        case .code2:
            break
        }
    }
    // 私有方法
    private func _privateFunction(s: String, s1: String) {
        let v1: UIView? = UIView()
        let v2: UIView? = UIView()
        if let _ = v1, let _ = v2 {
            
        }
        if v1 != nil {
            
        }
        
        /*❌
         if (s == "s") {
            
         }
        */
        if s.isEmpty {
            // Use n here
        } else {
            return
        }
        // 尽早退出判断的使用guard，减少嵌套使用guard
        guard s.isEmpty else {
            return
        }
    }
    
    private func _privateForFunction() {
        for _ in 0..<3 {
            print("Hello three times")
        }
        
        for (index, person) in dic.enumerated() {
            print("\(person) is at position #\(index)")
        }
    
        for index in (0...3).reversed() {
            print(index)
        }
    }
    
    // MARK: getters and setters
    lazy var standardView: UIView = {
        let v = UIView()
        return v
    }()
    // 私有方法命名前加_
    private func _initViews() {
        self.view.addSubview(standardView)
    }
}

// MARK: delegate function 1
extension ZHCodeStandardViewController {
    
}

// MARK: delegate function 2
extension ZHCodeStandardViewController {
    
}

// MARK: delegate function 3
extension ZHCodeStandardViewController {
    
}


// MARK: ZHCodeStandardModel
class ZHCodeStandardModel {
    
}

// MARK: PXHomeTopAnimatingButton
class PXHomeTopAnimatingButton: UIButton {
    // 调用组件XIB文件
    private func _loadView() -> PXCustomButton {
        let bundle = Bundle.init(for: self.classForCoder)
        let v = bundle.loadNibNamed("PXCustomButton", owner: self, options: nil)?.last as! PXCustomButton
        return v
    }
    // 使用组件内的图片
    private func _initImage() {
        let scale: CGFloat = UIScreen.main.scale
        let bundle = Bundle.init(for: self.classForCoder)
        let imageName = "imageName@" + scale.toString() + "x.png"
        guard let path = bundle.path(forResource: imageName, ofType: nil, inDirectory: "组件名.bundle") else {
            return
        }
        let image = UIImage(contentsOfFile: path)
        print(image ?? "nil")
    }
    // 字体和图片类似
}
// ❌
class PXCustomButton: UIButton {
    
}



