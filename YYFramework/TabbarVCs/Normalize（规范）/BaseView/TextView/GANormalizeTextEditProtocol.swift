//
//  GANormalizeTextEdit.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/18.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

protocol GANormalizeTextEditRegulayProtocol {
    func _judgeNumbser(string: String) -> Bool
    func _judgeLetterAndNumber(string: String) -> Bool
    func _judgeRegular(string: String, regularString: String) -> Bool
    func _judgeSpecialChar(string: String) -> Bool
    func _judgeChineseChar(string: String) -> Bool
    func _judgeLetter(string: String) -> Bool
}

protocol GANormalizeTextEditMaxCountProtocol {
    func _limitTextLength()
    func _subString(to: Int) -> String
}


