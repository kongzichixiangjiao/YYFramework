//
//  Font.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

extension Double {
    var font: UIFont {
        return UIFont.systemFont(ofSize: CGFloat(self))
    }
}

extension Int {
    var font: UIFont {
        return UIFont.systemFont(ofSize: CGFloat(self))
    }
}

