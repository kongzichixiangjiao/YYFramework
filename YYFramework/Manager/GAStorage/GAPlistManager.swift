//
//  GAPlistManager.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/14.
//  Copyright © 2018年 houjianan. All rights reserved.
//  plist文件读写管理类

/*
    GAPlistManager.share.writeArrayPlist(data: ["123", "123123"], fileName: "test5")
    GAPlistManager.share.removeArrayPlist(fileName: "test3")
 
    GAPlistManager.share.yy_fileNames()
 */

import Foundation

typealias GAPlistManagerFinishedHandler = (_ finish: Bool) -> ()

class GAPlistManager {
    
    static let share: GAPlistManager = GAPlistManager()
    
    private let kGAPlistManagerFileNames = "comJiananGA"
    
    private var ga_lock: NSLock = NSLock()
    
    public func plistPath(name: String = "yy") -> String {
        let path = NSHomeDirectory() + "/Documents/yyplist"
        
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        
        let fileName = name + ".plist"
        
        return path + "/" + fileName
    }
    
    public func writeDicPlist(data: [String : Any], fileName: String, handler: @escaping GAPlistManagerFinishedHandler) {
        let dic = data as NSDictionary
        if dic.write(toFile: plistPath(name: fileName), atomically: true) {
            writeFileName(fileName: fileName)
            handler(true)
        } else {
            handler(false)
        }
    }
    
    public func readDicPlist(fileName: String) -> [String : Any]? {
        let json = NSDictionary(contentsOfFile: plistPath(name: fileName)) as? [String : Any]
        return json
    }
    
    public func writeArrayPlist(data: [Any], fileName: String) -> Bool {
        let array = data as NSArray
        if array.write(toFile: plistPath(name: fileName), atomically: true) {
            writeFileName(fileName: fileName)
            return true
        } else {
            return false
        }
    }
    
    public func readArrayPlist(fileName: String) -> [Any]? {
        return NSArray(contentsOfFile: plistPath(name: fileName)) as? [Any]
    }
    
    public func removeArrayPlist(fileName: String, handler: @escaping GAPlistManagerFinishedHandler) -> Bool {
        if FileManager.default.isDeletableFile(atPath: plistPath(name: fileName)) {
            DispatchQueue.global().async {
                [weak self] in
                if let weakSelf = self {
                    try? FileManager.default.removeItem(atPath: weakSelf.plistPath(name: fileName))
                    weakSelf.deleteFileName(fileName: fileName)
                    DispatchQueue.main.async {
                        handler(true)
                    }
                }
            }
            return true
        }
        return false
    }
    
    public func yy_fileNames() -> [String] {
        let array = NSArray(contentsOfFile: plistPath(name: kGAPlistManagerFileNames)) as? [String] ?? []
        return array
    }
    
    public func getLocalArray(fileName: String) -> [[String : Any]] {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            #if DEBUG
            print("fileName 错误")
            #endif
            return []
        }
        
        let arr = NSArray.init(contentsOf: URL(fileURLWithPath: path)) as! [[String : Any]]
        return arr
    }
    
    private func writeFileName(fileName: String) {
        var array = yy_fileNames()
        if !array.contains(fileName) {
            array.append(fileName)
            _ = (array as NSArray).write(toFile: plistPath(name: kGAPlistManagerFileNames), atomically: true)
        }
    }
    
    private func deleteFileName(fileName: String) {
        var array = yy_fileNames()
        var index = -1
        for i in 0..<array.count {
            if fileName == array[i] {
                index = i
            }
        }
        
        if index != -1 {
            array.remove(at: index)
        }
        
        _ = (array as NSArray).write(toFile: plistPath(name: kGAPlistManagerFileNames), atomically: true)
    }
    
    deinit {
        print( "deinit GAPlistManager")
    }
}
