//
//  GAGlobal+Log.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/27.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

/// 自定义打印函数
func gaLog(_ message: Any, file: String = #file, _ line: Int = #line) {
    #if DEBUG
    let filename =  (file as NSString).lastPathComponent
    
    print("\(filename)-[第\(line)行]: \(message)")
    
    #endif
}
