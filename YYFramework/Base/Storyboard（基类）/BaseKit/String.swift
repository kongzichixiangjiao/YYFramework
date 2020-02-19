//
//  String.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

extension String {
    var int: Int? {
        return Int(self)
    }
    
    var intValue: Int {
        return Int(self) ?? 0
    }
    
    var float: Float? {
        return Float(self)
    }
    
    var floatValue: Float {
        return Float(self) ?? 0
    }
    
    var double: Double? {
        return Double(self)
    }
    
    var doubleValue: Double {
        return Double(self) ?? 0
    }
}

extension Optional where Wrapped == String {
    var int: Int? {
        return self?.int
    }
    
    var intValue: Int {
        return self?.intValue ?? 0
    }
    
    var float: Float? {
        return self?.float
    }
    
    var floatValue: Float {
        return self?.floatValue ?? 0
    }
    
    var double: Double? {
        return self?.double
    }
    
    var doubleValue: Double {
        return self?.doubleValue ?? 0
    }
    
    var length: Int {
        return self?.count ?? 0
    }
}

extension String {
    var url : URL? {
        return URL(string: self)
    }
}

extension String {
    
    static var homePath: String {
        return NSHomeDirectory()
    }
    
    static var documentPath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return paths.first!
    }
    
    static var cachePath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
        return paths.first!
    }
    
    static var libraryPath: String {
        let paths = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)
        return paths.first!
    }
    
    static var tmpPath: String {
        return NSTemporaryDirectory()
    }
    
    static func directory(fromPath path: String, dirName name: String) -> String {
        let dirPath = (path as NSString).appendingPathComponent(name)
        try? FileManager().createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
        return dirPath
    }
    
    static func path(forPath path: String, fileName name: String, inDirName dirName: String? = nil) -> String {
        let dirPath: String
        if let dirName = dirName {
            dirPath = directory(fromPath: path, dirName: dirName)
        } else {
            dirPath = path
        }
        return (dirPath as NSString).appendingPathComponent(name)
    }
    
    static func deviceID() -> String {
        let userDefault = UserDefaults.standard
        let deviceID: String
        if let udid = userDefault.string(forKey: "UDID") {
            deviceID = udid
        } else {
            if let udid = UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "") {
                deviceID = udid
            } else {
                deviceID = String(Date().timeIntervalSince1970) + String(arc4random()%100000)
            }
            userDefault.setValue(deviceID, forKey: "UDID")
            userDefault.synchronize()
        }
        return deviceID
    }
}

// 国际化
extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "")
    }
}

