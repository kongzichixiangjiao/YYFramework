//
//  GAIphoneType.swift
//  PuXinFinancial
//
//  Created by 侯佳男 on 2018/12/10.
//  Copyright © 2018年 ZHENGHE. All rights reserved.
//

import Foundation
import UIKit

enum GALaunchImageType: String {
    case none = "",
         iPhoneSE = "iPhoneSE",
         iPhone6_7_8 = "iPhone6_7_8",
         iPhoneX_XS = "iPhoneX_XS",
         iPhoneXR_XSMax = "iPhoneXR_XSMax"
}

extension CGFloat {
    static func ga_useLaunchImageType() -> GALaunchImageType {
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        if w == 414 && h == 896 {
            return .iPhoneXR_XSMax
        } else if w == 375 && h == 812 {
            return .iPhoneX_XS
        } else if w == 414 && h == 736 {
            return .iPhone6_7_8
        } else if w == 375 && h == 667 {
            return .iPhone6_7_8
        } else {
            return .none
        }
    }
}
