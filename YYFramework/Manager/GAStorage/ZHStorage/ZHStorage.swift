//
//  ZHStorage.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/12.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

/*
 *  常用的字段写成方法，一些判断在此处判断（登录、实名、理财师等）
 */
protocol ZHStorageModelProtocol {
    func zh_saveName(value: String)
}

class ZHStorage: GAStorage {
    private let kFileName: String = "ZHStorage_jinfu"
    
    static let zh: ZHStorage = ZHStorage()
    
    // MARK: 获取json
    public func zh_getAll() -> [String : Any] {
        return ga_getAll(fileName: kFileName)
    }
    // MARK: 获取对象
    public func zh_getModel() -> ZHStorageModel? {
        let dic = ga_getAll(fileName: kFileName)
        let model = ZHStorageModel.deserialize(from: dic)
        return model
    }
    
    // MARK: 取一个值
    public func zh_getValue(key: String) -> Any? {
        return ga_getValue(key: key, fileName: kFileName)
    }
    
    // MARK: 存 GAJSON
    public func zh_save(model: GAJSON) {
        ga_save(model: model, fileName: kFileName)
    }
    // MARK: 删除
    public func zh_deleteAll(handler: @escaping GAPlistManagerFinishedHandler) -> Bool {
        return ga_deleteAll(fileName: kFileName, handler: handler)
    }
}

extension ZHStorage: ZHStorageModelProtocol {
    func zh_saveName(value: String) {
        ZHStorageModel.zh.name = value
        zh_save(model: ZHStorageModel.zh)
    }
}

