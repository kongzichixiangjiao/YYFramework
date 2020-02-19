//
//  GABaseDefine.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/22.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

var GABaseBackColor: UIColor = .white 

var GASafeTopHeight: CGFloat {
    if #available(iOS 11.0, *) {
        guard let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
            return 20
        }
        return max(20, safeAreaInsets.top)
    } else {
        return 20
    }
}

var GASafeBottomHeight: CGFloat {
    if #available(iOS 11.0, *) {
        guard let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
            return 0
        }
        return safeAreaInsets.bottom
    } else {
        return 0
    }
}
