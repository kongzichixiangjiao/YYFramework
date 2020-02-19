//
//  NSArray+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/25.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

extension NSArray {
    
    var ga_removeRepetition: NSArray! {
        let set = NSSet(array: self as! [Any])
        return set.allObjects as NSArray
    }
    
}

extension Array {
    // 去重
    /*
        let arr = [1, 2, 2, 3, 1, 3]
        let filterArr = arr.filterDuplicates({$0})
        print(filterArr)
     */
    func ga_filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
    
    static func ga_init_IntArray(start: Int, end: Int) -> Array<Int> {
        var arr = [Int]()
        for i in start..<end {
            arr.append(i)
        }
        return arr
    }

}


extension Array {
    var ga_jsonString: String {
        guard let data = try? JSONSerialization.data(withJSONObject: self) else {
            return ""
        }
        guard let jsonString = String(data: data, encoding: .utf8) else {
            return ""
        }
        return jsonString
    }
}

extension Array {
    func ga_get(_ count: Int) -> Any? {
        if self.count == 0 {
            return nil
        }
        if self.count <= count {
            return nil
        }
        return self[count]
    }
}
