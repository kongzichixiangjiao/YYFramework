//
//  ZHModel.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/31.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation
import HandyJSON

class ZHModel: HandyJSON {
    
    var returnCode: Int?
    var message: String?
    var result: Any?
    var resultDic: [String : Any]?
    
    required init() {}
}
