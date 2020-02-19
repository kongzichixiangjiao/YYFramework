//
//  GAVantUIModel.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/6.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation
import HandyJSON

class GAVantUIModel: HandyJSON {
    var isShow: Bool = false
    var sectionIcon = ""
    var sectionTitle = ""
    var rows: [GAVantUIRowModel] = []
    
    required init() {
        
    }
}

class GAVantUIRowModel: HandyJSON {
    var icon = ""
    var isLast = false
    var title = ""
    var vc = ""
    
    required init() {
        
    }
}
