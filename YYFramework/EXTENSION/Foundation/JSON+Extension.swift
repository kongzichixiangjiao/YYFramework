//
//  JSON+Extension.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/19.
//  Copyright © 2019年 houjianan. All rights reserved.
//

/*
 *  1、数组转json串
 *  2、字典转json串
 *  3、json串转数组
 *  4、json串转字典
 */

import Foundation

// NSArray -> JSON
extension NSArray {
    
    var ga_toJSON: String! {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [JSONSerialization.WritingOptions.prettyPrinted])
            return String(data: data, encoding: String.Encoding.utf8)!
        } catch {
            
        }
        
        return ""
    }
}

// NSDictionary -> JSON
extension NSDictionary {
    
    var ga_toJSON: String! {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [JSONSerialization.WritingOptions.prettyPrinted])
            return String(data: data, encoding: String.Encoding.utf8)!
        } catch {
            
        }
        
        return ""
    }
}

// JSON -> NSArray  JSON -> NSDictionary
extension String {
    var ga_jsonToArray: NSArray {
        
        let jsonData:Data = self.data(using: .utf8)!
        
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray
    }
    
    var ga_jsonToDic: NSDictionary {
        let jsonData:Data = self.data(using: .utf8)!
        
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
}

