//
//  GALocalFileCapacityManager.swift
//  YYFramework
//
//  Created by houjianan on 2019/3/4.
//  Copyright © 2019 houjianan. All rights reserved.
//  本地文件存储容量 清除缓存

import Foundation

class GALocalFileCatchManager {
    let fileManager = FileManager.default
    
    func ga_fileSizeOfCache(baseSize: Int = 1024*1024) -> Float {
        // 获取Caches目录路径和目录下所有文件
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first,
            let files = fileManager.subpaths(atPath: cachePath) else {
                return 0
        }
        //枚举出所有文件，计算文件大小
        var folderSize :Float = 0.0
        for file in files {
            // 路径拼接
            let path = cachePath + "/" + "\(file)"
            #if DEBUG
            print(path)
            #endif
            // 计算缓存大小
            folderSize  += ga_fileSizeAtPath(path:path)
        }
        return folderSize/Float(baseSize)
    }
    
    func ga_fileSizeAtPath(path: String, digits: Int = 2) -> Float {
        if fileManager.fileExists(atPath: path) {
            let attr = try! fileManager.attributesOfItem(atPath: path)
            
            let arr = String(attr[FileAttributeKey.size] as! UInt32).components(separatedBy: ".")
            var s: String = (arr.first ?? "0") + "."
            s = s + String((arr.last ?? "").prefix(digits))
            
            return Float(s) ?? 0.0
        }
        return 0.0
    }
    
    func ga_clearCache() {
        guard let cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first, let files = fileManager.subpaths(atPath: cachePath) else {
                return
        }
        
        for file in files {
            let path = cachePath + "/" + "\(file)"
            #if DEBUG
            print(path)
            #endif
            if fileManager.fileExists(atPath: path) {
                do {
                    try fileManager.removeItem(atPath: path)
                } catch  {
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                }
            }
        }
    }
}
