//
//  GAJSON.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/12.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

protocol GAJSON {
    func ga_toJSON() -> AnyObject?
    func ga_toJSONString() -> String?
}

extension GAJSON {
    
    public func ga_toJSON() -> AnyObject? {
        let mirror = Mirror(reflecting: self)
        if mirror.children.count == 0 {
            return self as AnyObject
        }
        
        var result = [String : AnyObject]()
        var superclassMirror = mirror.superclassMirror
        
        while superclassMirror != nil {
            for (key, value) in superclassMirror!.children {
                if let jsonValue = value as? GAJSON {
                    result[key!] = jsonValue.ga_toJSON()
                }
            }
            superclassMirror = superclassMirror?.superclassMirror
        }
        
        for (key, value) in mirror.children {
            if let jsonValue = value as? GAJSON {
                result[key!] = jsonValue.ga_toJSON()
            } else {
                result[key!] = _returnDefaultValue(mirror: Mirror(reflecting: value))
            }
        }
        return result as AnyObject
    }
    
    // Mirror反射
    /*
     所谓反射就是可以动态获取类型、成员信息，在运行时可以调用方法、属性等行为的特性。 在使用OC开发时很少强调其反射概念，因为OC的Runtime要比其他语言中的反射强大的多。不过在Swift中并不提倡使用Runtime，而是像其他语言一样使用反射(Reflect)，即使目前Swift中的反射功能还比较弱，只能访问获取类型、成员信息。
     
     Swift的反射机制是基于一个叫Mirror的结构体来实现的。你为具体的实例创建一个Mirror对象，然后就可以通过它查询这个实例
     
     Mirror结构体常用属性：
        subjectType：对象类型
        children：反射对象的属性集合
        displayStyle：反射对象展示类型
     */
    private func _returnDefaultValue(mirror: Mirror) -> AnyObject {
        if mirror.subjectType == Optional<Swift.String>.self {
            return "" as AnyObject
        } else if mirror.subjectType == Optional<Swift.Int>.self {
            return 0 as AnyObject
        } else if mirror.subjectType == Optional<Swift.UInt>.self {
            return 0 as AnyObject
        } else if mirror.subjectType == Optional<Swift.Double>.self {
            return 0.0001 as AnyObject
        } else if mirror.subjectType == Optional<Swift.Float>.self {
            return 0.01 as AnyObject
        } else if mirror.subjectType == Optional<Swift.Bool>.self {
            return false as AnyObject
        } else if mirror.subjectType == Any.Type.self {
            return "" as AnyObject
        } else {
            return "" as AnyObject
        }
    }
    
    public func ga_toJSONString() -> String? {
        guard let json = self.ga_toJSON() else {
            return nil
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: json, options: []) else {
            return nil
        }
        let resultString = String(data: data, encoding: String.Encoding.utf8)
        return resultString
    }
}

extension Optional: GAJSON {
    public func ga_toJSON() -> AnyObject? {
        // Flutter 私有变量 _self
        if let _self = self {
            if let value = _self as? GAJSON {
                return value.ga_toJSON()
            }
        }
        return nil
    }
}

extension Array: GAJSON {
    
    public func ga_toJSON() -> AnyObject? {
        var results: [AnyObject] = []
        for item in self {
            if let obj = item as? GAJSON {
                if let json = obj.ga_toJSON() {
                    results.append(json)
                }
            }
        }
        return results as AnyObject
    }
}

extension Dictionary: GAJSON {
    
    public func ga_toJSON() -> AnyObject? {
        var results: [String: AnyObject] = [:]
        for (key, value) in self {
            if let key = key as? String {
                if let value = value as? GAJSON {
                    if let json = value.ga_toJSON() {
                        results[key] = json
                        continue
                    }
                } else {
                    results[key] = value as AnyObject
                    continue
                }
                results[key] = nil
            }
        }
        return results as AnyObject
    }
    
}
extension Date: GAJSON {
    public func ga_toJSON() -> AnyObject? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: self) as AnyObject
    }
}

extension String: GAJSON {}
extension Int: GAJSON {}
extension Int8: GAJSON {}
extension Int16: GAJSON {}
extension Int32: GAJSON {}
extension Int64: GAJSON {}
extension UInt: GAJSON {}
extension UInt8: GAJSON {}
extension UInt16: GAJSON {}
extension UInt32: GAJSON {}
extension UInt64: GAJSON {}
extension Bool: GAJSON {}
extension Float: GAJSON {}
extension Double: GAJSON {}
