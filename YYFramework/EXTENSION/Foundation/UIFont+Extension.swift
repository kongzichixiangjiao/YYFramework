//
//  UIFont+Extension.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/22.
//  Copyright © 2019年 houjianan. All rights reserved.
//

/*
 *  快速初始化Weight类型字体
 */

import UIKit

extension UIFont {

    static func ga_regularFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.regular)
    }
    
    static func ga_mediumFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.medium)
    }
    
    static func ga_semiboldFont(ofSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: ofSize, weight: UIFont.Weight.semibold)
    }
}
