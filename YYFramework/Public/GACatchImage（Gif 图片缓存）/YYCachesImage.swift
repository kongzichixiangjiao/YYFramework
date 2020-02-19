//
//  YYFileManager.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/14.
//  Copyright © 2018年 houjianan. All rights reserved.
//  图片缓存类

import UIKit

import UIKit

open class YYCachesImage: NSObject {
    
    private let kName: String = "name"
    private let kType: String = "type"
    
    static let share: YYCachesImage = YYCachesImage()
    
    public typealias CachesImageHandler = (_ finish: Bool) -> ()
    
    public func writeLocalImage(data: Data, key: String, handler: CachesImageHandler?) {
        DispatchQueue.global().async {
            let filePath = self.catchImagesPath()
            let name = key.md5
            let imgPath = filePath + name!
            if FileManager.default.isWritableFile(atPath: filePath) {
                try! data.write(to: URL(fileURLWithPath: imgPath))
                
                self.writePlist(data: data, name: name!)
                
                DispatchQueue.main.async {
                    handler!(true)
                }
            } else {
                DispatchQueue.main.async {
                    handler!(false)
                }
            }
        }
    }
    
    public func writeLocalImage(image: UIImage, key: String, handler: CachesImageHandler?) {
        let data = image.pngData()
        writeLocalImage(data: data!, key: key, handler: handler)
    }
    
    public func readLocalData(key: String, handler: CachesImageHandler?) -> Data? {
        let model = readPlist(key: key)
        guard let name = model[kName] else {
            return nil
        }
        
        if FileManager.default.fileExists(atPath: catchImagesPath() + name) {
            return try! Data(contentsOf: URL(fileURLWithPath: catchImagesPath() + name))
        }
        
        return nil
    }
    
    public func readLocalImage(key: String, handler: CachesImageHandler?) -> UIImage? {
        if let imageData = readLocalData(key: key, handler: nil) {
            return UIImage(data: imageData)
        }
        
        return nil
    }
    
    public func deleteLocal(key: String, handler: CachesImageHandler?) {
        removeImageData(atPath: catchImagesPath(), key: key, handler: handler)
        removePlistItem(key: key)
    }
    
    public func removeAllFile() -> Bool {
        if FileManager.default.isDeletableFile(atPath: catchImagesPath()) {
            try? FileManager.default.removeItem(atPath: catchImagesPath())
            return true
        } else {
            return false
        }
    }
    
    public func catchImagesByte() -> Float {
        var fileSize:Float = 0.0
        if FileManager.default.fileExists(atPath: catchImagesPath()) {
            
                if let attr: NSDictionary = try? FileManager.default.attributesOfItem(atPath: catchImagesPath()) as NSDictionary {
                    fileSize = Float(attr.fileSize())
                }
            
        }
        return fileSize
    }
    
    private func removePlistItem(key: String) {
        let name = key.md5
        var array = NSArray(contentsOfFile: plistPath()) as? [[String : String]] ?? [["":""]]
        var index = -1
        for i in 0..<array.count {
            if (array[i][kName] == name) {
                index = i
            }
        }
        if index != -1 {
            array.remove(at: index)
            (array as NSArray).write(toFile: plistPath(), atomically: true)
        }
    }
    
    private func removeImageData(atPath: String, key: String, handler: CachesImageHandler?) {
        if FileManager.default.fileExists(atPath: atPath + key.md5) {
            try! FileManager.default.removeItem(atPath: atPath + key.md5)
        }
    }
    
    private func catchImagesPath() -> String {
        let newPath = NSHomeDirectory() + "/Documents/yyimages/"
        
        if !FileManager.default.fileExists(atPath: newPath) {
            print(newPath)
            try! FileManager.default.createDirectory(atPath: newPath, withIntermediateDirectories: true, attributes: nil)
        }
        
        return newPath
    }
    
    private func plistPath() -> String {
        let newPath = NSHomeDirectory() + "/Documents/yyimages/plist"
        
        if !FileManager.default.fileExists(atPath: newPath) {
            try! FileManager.default.createDirectory(atPath: newPath, withIntermediateDirectories: true, attributes: nil)
        }
        
        return newPath + "/img.plist"
    }
    
    private func writePlist(data: Data, name: String) {
        let type = GAImageType.checkDataType(data: data).rawValue
        var array = NSArray(contentsOfFile: plistPath()) as? [[String : String]] ?? [["":""]]
        var isHas: Bool = false
        for a in array {
            if (a[kName] == name && a[kType] == type) {
                isHas = true
            }
        }
        
        if !isHas {
            let model = [kType : type, kName : name]
            if (array == [["":""]]) {
                array.removeAll()
            }
            array.append(model)
            (array as NSArray).write(toFile: plistPath(), atomically: true)
        }
    }
    
    private func readPlist(key: String) -> [String : String] {
        let name = key.md5
        let array = NSArray(contentsOfFile: plistPath()) as? [[String : String]] ?? [["":""]]
        for a in array {
            if (a[kName] == name) {
                return a
            }
        }
        return ["":""]
    }
    
}


