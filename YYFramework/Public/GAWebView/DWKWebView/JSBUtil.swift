//
//  JSBUtil.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/17.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

enum DSB_API_TYPE: Int {
    case DSB_API_HASNATIVEMETHOD = 0,
    DSB_API_CLOSEPAGE = 1,
    DSB_API_RETURNVALUE = 2,
    DSB_API_DSINIT = 3,
    DSB_API_DISABLESAFETYALERTBOX = 4
}

class JSBUtil {
    
    static func objToJsonString(dict: Any) -> String {
        if !(JSONSerialization.isValidJSONObject(dict)) {
            return "{}"
        } 

        var jsonData: Data?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: dict, options: [])
        } catch {
            return "{}"
        }
        if jsonData != nil {
            let jsonString = String(data: jsonData!, encoding: String.Encoding.utf8)
            return jsonString!
        } else {
            return "{}"
        }
    }
    static func allMethodFromClass(classImem: NSObject) -> [String] {
        var methods: [String] = []
        
        var count:UInt32 = 0
        let method = class_copyMethodList(classImem.classForCoder, &count)
        
        for i in 0..<count {
            let methodName = method_getName(method![Int(i)])
            let selName = sel_getName(methodName)
            let strName = String(cString: selName, encoding: String.Encoding.utf8)
            methods.append(strName!)
        }
        
        return methods
    }
    //return method name for xxx: or xxx:handle:
    static func method(argNum: Int, selName: String, classItem: NSObject) -> String? {
        let arr = JSBUtil.allMethodFromClass(classImem: classItem)
        for i in 0..<arr.count {
            let method = arr[i]
            let tmpArr = method.components(separatedBy: ":")
//            let filterArray = tmpArr.filterDuplicates({$0})
            let range: NSRange = (method as NSString).range(of: ":")
            if range.length > 0 {
                let sel = tmpArr[0]
                if sel == selName  {
                    if tmpArr.count == argNum + 1 {
                        return method
                    }
                }
            }
        }
        return nil
    }
    static func parseNamespace(method: String) -> [String] {
        let arr = method.components(separatedBy: ".")
        if arr.count == 1 {
            return ["", arr.last ?? ""]
        }
        return [arr.first ?? "", arr.last ?? ""]
    }
    
    static func jsonStringToObject(jsonString: String) -> Any {
        var newJsonString = jsonString
        if (newJsonString.contains("{}")) {
            newJsonString = newJsonString.replacingOccurrences(of: "{}", with: "null")
        }
        let jsonData = newJsonString.data(using: String.Encoding.utf8)
        let dic = try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
        var dic1 = (dic as! [String : Any])
        if newJsonString.contains("null") {
            dic1["data"] = ["":""]
        }
        return dic1
    }
}

extension NSObject {
    // MARK:返回className
    var className:String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){
                return name.components(separatedBy: ".")[1];
            }else{
                return name;
            }
        }
    }
}

extension Array {
    // 去重
    /*
     let arr = [1, 2, 2, 3, 1, 3]
     let filterArr = arr.filterDuplicates({$0})
     print(filterArr)
     */
    func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}

