//
//  GAStorage.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/17.
//  Copyright © 2018年 houjianan. All rights reserved.
//

/*
     let model = TestModel()
     model.name = "1"
     model.age = 1
     GAStorage().ga_save(model: model, fileName: "test")
     print("01--", GAStorage().ga_get(fileName: "test"))
 */

import Foundation

class GAStorage {
    
    static let share: GAStorage = GAStorage()
    // MARK: 取
    public func ga_getAll(fileName: String) -> [String : Any] {
        return _get(fileName: fileName)
    }
    
    // MARK: 取一个值
    public func ga_getValue(key: String, fileName: String) -> Any? {
        let dic = _get(fileName: fileName)
        guard let value = dic[key] else {
            return nil 
        }
        return value
    }
    
    // MARK: 存 GAJSON
    public func ga_save(model: GAJSON, fileName: String) {
        _save(model: model, fileName: fileName)
    }
    
    public func ga_deleteAll(fileName: String, handler: @escaping GAPlistManagerFinishedHandler) -> Bool {
        return GAPlistManager.share.removeArrayPlist(fileName:fileName, handler: handler)
    }
    
    private func _get(fileName: String) -> [String : Any] {
        return GAPlistManager.share.readDicPlist(fileName: fileName) ?? ["":""]
    }
    
    private func _save(model: GAJSON, fileName: String) {
        let json = model.ga_toJSON()
        GAPlistManager.share.writeDicPlist(data: json as! [String : Any], fileName: fileName, handler: {
            finish in
            #if DEBUG
            print("存储完成")
            #endif
        })
    }
}

