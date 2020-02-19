//
//  ZHLog.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/30.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

func zhLog<T>(_ message:T, file:String = #file, function:String = #function,
            line:Int = #line) {
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    //打印日志内容
    print("\(fileName):\(line) \(function) | \(message)")
    #endif
}

