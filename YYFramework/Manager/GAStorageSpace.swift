//
//  GAStorageSpace.swift
//  FinancialPlanner
//
//  Created by houjianan on 2019/11/12.
//  Copyright © 2019 PUXIN. All rights reserved.
//  系统存储空间

import UIKit


class GAStorageSpace {
    static func getFreeSpace() -> Int64 {
        do {
            let attributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            return attributes[FileAttributeKey.systemFreeSize] as! Int64
        } catch {
            return 0
        }
    }
    
    static func getTotalSpace() -> Int64 {
        do {
            let attributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())
            return attributes[FileAttributeKey.systemFreeSize] as! Int64
        } catch {
            return 0
        }
    }
    
    static func getUsedSpace() -> Int64 {
        return getTotalSpace() - getFreeSpace()
    }
}

extension Int64 {
    func ga_toMB() -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = ByteCountFormatter.Units.useMB
        formatter.countStyle = ByteCountFormatter.CountStyle.decimal
        formatter.includesUnit = false
        return formatter.string(fromByteCount: self) as String
    }
}
