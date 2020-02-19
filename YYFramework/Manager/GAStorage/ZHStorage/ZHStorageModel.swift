//
//  ZHStorageModel.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/12.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation
import HandyJSON

class ZHStorageModel: GAJSON, HandyJSON {
    
    static let zh: ZHStorageModel = ZHStorageModel()
    
    var name: String = ""
    var age: Int = 0
    var numbers: Int!
    var d: Double!
    
    required init() {
        
    }
    
}
