//
//  YYScrollADViewModel.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class YYADViewModel {
    var font: UIFont = UIFont.systemFont(ofSize: 14)
}

class YYScrollADViewModel {
    var font: UIFont = UIFont.systemFont(ofSize: 14)
    var direction: YYScrollADViewDirection = .left
    var type: YYScrollADViewType = .continuous
    var textWidth: CGFloat = 0
    var text: String = "" {
        didSet {
            self.textWidth = (text as NSString).size(withAttributes: [NSAttributedString.Key.font:font]).width
        }
    }
    var speed = 0.03
}

class YYTableADViewModel {
    var text: String = ""
    var url: String = ""
}
