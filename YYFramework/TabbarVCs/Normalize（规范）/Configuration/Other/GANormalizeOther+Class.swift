//
//  GANormalizeClass.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/25.
//  Copyright © 2019年 houjianan. All rights reserved.
//

/*
 *  基础颜色、字体大小、设备（尺寸相关）
 *  字体和颜色在GANormalizeOther配置好，可直接使用
 */

import Foundation
import UIKit

open class GANormalizeFont {
    // 特大字体：金额、验证码
    static let kEspeciallyBig_26_LevelFontSize: CGFloat = 26.0
    static let kEspeciallyBig_30_LevelFontSize: CGFloat = 30.0
    static let kEspeciallyBig_36_LevelFontSize: CGFloat = 36.0
    // 标题：1级标题
    static let kHeadline_H1_FontSize: CGFloat = 21.0
    // 标题：2级标题
    static let kHeadline_H2_FontSize: CGFloat = 18.0
    // 标题：3级标题、大按钮
    static let kHeadline_H3_FontSize: CGFloat = 16.0
    // 正文：表单内容
    static let kMainBody_14_LevelFontSize: CGFloat = 14.0
    // 正文：文章、底部弹框选项
    static let kMainBody_15_LevelFontSize: CGFloat = 15.0
    // 辅助：标签栏文字
    static let kAssist_10_LevelFontSize: CGFloat = 10.0
    // 辅助：提示性用于、线性小按钮
    static let kAssist_12_LevelFontSize: CGFloat = 12.0
}

open class GANormalizeColor {
    // 主色：强调重点、按钮、icon等
    static let kMainColorString = "b48856"
    // 主背景色：适用于所有背景、底板
    static let kMainBackgroundColorString = "f8f8f8"
    // 次级背景色：适用于列表展开底板
    static let kSecondaryBackgroundColorString = "fcfcfc"
    // 线条：分割线 level越大 颜色越深
    static let kSeptalLine_1_LevelColorString = "ebebeb"
    // 线条：常规按钮描边
    static let kSeptalLine_2_LevelColorString = "cccccc"
    // 线条：空界面按钮描边
    static let kSeptalLine_3_LevelColorString = "666666"
    
    // MARK: 字体颜色
    // level越大 颜色越深
    static let kFont_1_c_LevelColorString = "cccccc"
    static let kFont_2_9_LevelColorString = "999999"
    static let kFont_3_6_LevelColorString = "666666"
    static let kFont_4_3_LevelColorString = "333333"
    
    static let kShadowColorString = "999999"
    
    static let kMainButtonDefaultColorString = "b48856"
    static let kMainButtonHighlightColorString = "a37c4e"
    static let kMainButtonSelectedColorString = "a37c4e"
    static let kMainButtonDisabledColorString = "cccccc"
    
    static let kMaskLayerColorString = "000000"
}

open class GANormalizeDevice {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    static var scale: CGFloat {
        return UIScreen.main.scale
    }
    static var stateHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    static var tabbarHeight: CGFloat {
        let baseTabbarHeight: CGFloat = 49.0
         if #available(iOS 11.0, *) {
               guard let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
                   return baseTabbarHeight
               }
               return baseTabbarHeight + safeAreaInsets.bottom
           } else {
               return baseTabbarHeight
           }
//        guard let deviceType = GANormalizeDeviceType.init(rawValue: UIDevice.current.normalize_modelName) else {
//            print("deviceTabbarHeight 设备出错")
//            return baseTabbarHeight
//        }
//
//        if deviceType == .Simulator {
//            let simulatorDeviceType = CGFloat.normalize_useLaunchImageType()
//            switch simulatorDeviceType {
//            case .iPhone6_7_8, .iPhoneSE:
//                return baseTabbarHeight
//            case .iPhoneX_XS, .iPhoneXR_XSMax:
//                return baseTabbarHeight + 34.0
//            case .none:
//                return baseTabbarHeight
//            }
//        }
//
//        if deviceType == .iPhoneX || deviceType == .iPhoneXS || deviceType == .iPhoneXR || deviceType == .iPhoneXSMax {
//            return baseTabbarHeight + 34.0
//        }
//        return baseTabbarHeight
    }
}
