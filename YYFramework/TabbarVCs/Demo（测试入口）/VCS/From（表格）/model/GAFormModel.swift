//
//  GAFormModel.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation
import HandyJSON

class GAFormModel: HandyJSON {
    var isShow: Bool = false
    var sectionIcon = ""
    var sectionTitle = ""
    var rows: [[GAFormRowModel]] = []
    var columns: [GAFormRowModel] = []
    
    required init() {
        
    }
}

class GAFormRowModel: HandyJSON {
    var icon = ""
    var isLast = false
    var title = ""
    var vc = ""
    
    required init() {
        
    }
}


class GAFormConfigModel {
    
    var topViewHeight: CGFloat = 80.0
    var topSegmentationViewColor = UIColor.white
    var topItemViewColor = UIColor.orange 
    
    var lItemWidth: CGFloat = 80.0
    var rItemWidth: CGFloat = 50.0
    
    var itemHeaderHeight: CGFloat = 50.0
    var itemHeight: CGFloat = 40.0
    
}
