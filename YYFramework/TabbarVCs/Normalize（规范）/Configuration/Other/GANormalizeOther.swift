//
//  GANormalizeOther.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/22.
//  Copyright © 2019年 houjianan. All rights reserved.
//
/*
 *  系统尺寸相关、设备相关、颜色相关、文案相关、**通用的key**
 */

import UIKit

// MARK: 系统
let kScreenScale = GANormalizeDevice.scale
let kScreenWidth = GANormalizeDevice.width
let kScreenHeight = GANormalizeDevice.height
let kStatusBarHeight = GANormalizeDevice.stateHeight
let kTabBarHeight: CGFloat = GANormalizeDevice.tabbarHeight
let kLandscapeTabBarHeight: CGFloat = 30 // 横屏tabbar高度
let kNavigationHeight: CGFloat = 44.0
let kLandscapeNavigationHeight: CGFloat = 30.0 // 横屏nav高度
let kTopHeight: CGFloat = kTabBarHeight + kNavigationHeight
// MARK: Device
let kDeviceVersion = UIDevice.current.systemVersion
let kDeviceSystemName = UIDevice.current.systemName
let kDeviceName = UIDevice.current.name
let kDeviceModel = UIDevice.current.model

// MARK: App
// 版本号
let kAppShortVersion : String = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String
// App名字
let kAppName : String = Bundle.main.infoDictionary! ["CFBundleName"] as! String

// MARK: 颜色
// 主色：强调重点、按钮、icon等
let kMainColor = GANormalizeColor.kMainColorString.normalize_color0X
// 主背景色：适用于所有背景、底板
let kMainBackgroundColor = GANormalizeColor.kMainBackgroundColorString.normalize_color0X
// 次级背景色：适用于列表展开底板
let kSecondaryBackgroundColor = GANormalizeColor.kSecondaryBackgroundColorString.normalize_color0X
// 线条：分割线 level越大 颜色越深
let kSeptalLine_1_LevelColor = GANormalizeColor.kSeptalLine_1_LevelColorString.normalize_color0X
// 线条：常规按钮描边
let kSeptalLine_2_LevelColor = GANormalizeColor.kSeptalLine_2_LevelColorString.normalize_color0X
// 线条：空界面按钮描边
let kSeptalLine_3_LevelColor = GANormalizeColor.kSeptalLine_3_LevelColorString.normalize_color0X

// MARK: 字体颜色
// level越大 颜色越深
let kFont_1_c_LevelColor = GANormalizeColor.kFont_1_c_LevelColorString.normalize_color0X
let kFont_2_9_LevelColor = GANormalizeColor.kFont_2_9_LevelColorString.normalize_color0X
let kFont_3_6_LevelColor = GANormalizeColor.kFont_3_6_LevelColorString.normalize_color0X
let kFont_4_3_LevelColor = GANormalizeColor.kFont_4_3_LevelColorString.normalize_color0X
// 投影颜色
let kShadowColor = GANormalizeColor.kShadowColorString.normalize_color0X(0.15)
// 按钮状态颜色
let kMainButtonDefaultColor = GANormalizeColor.kMainButtonDefaultColorString.normalize_color0X
let kMainButtonHighlightColor = GANormalizeColor.kMainButtonHighlightColorString.normalize_color0X
let kMainButtonSelectedColor = GANormalizeColor.kMainButtonSelectedColorString.normalize_color0X
let kMainButtonDisabledColor = GANormalizeColor.kMainButtonDisabledColorString.normalize_color0X
// 遮罩层颜色
let kMaskLayerColor = GANormalizeColor.kMaskLayerColorString.normalize_color0X(0.3)

// MARK: 字体
// 特大字体：金额、验证码
let kEspeciallyBig_26_LevelFont = UIFont.systemFont(ofSize: GANormalizeFont.kEspeciallyBig_26_LevelFontSize)
let kEspeciallyBig_30_LevelFont = UIFont.systemFont(ofSize: GANormalizeFont.kEspeciallyBig_30_LevelFontSize)
let kEspeciallyBig_36_LevelFont = UIFont.systemFont(ofSize: GANormalizeFont.kEspeciallyBig_36_LevelFontSize)
// 标题：1级 2级 3级标题
let kHeadline_H1_Font = UIFont.systemFont(ofSize: GANormalizeFont.kHeadline_H1_FontSize)
let kHeadline_H2_Font = UIFont.systemFont(ofSize: GANormalizeFont.kHeadline_H2_FontSize)
let kHeadline_H3_Font = UIFont.systemFont(ofSize: GANormalizeFont.kHeadline_H3_FontSize)
// 正文：表单内容
let kMainBody_14_LevelFont = UIFont.systemFont(ofSize: GANormalizeFont.kMainBody_14_LevelFontSize)
// 正文：文章、底部弹框选项
let kMainBody_15_LevelFont = UIFont.systemFont(ofSize: GANormalizeFont.kMainBody_15_LevelFontSize)
// 辅助：标签栏文字
let kMainBody_10_LevelFont = UIFont.systemFont(ofSize: GANormalizeFont.kAssist_10_LevelFontSize)
// 辅助：提示性用于、线性小按钮
let kAssist_12_LevelFont = UIFont.systemFont(ofSize: GANormalizeFont.kAssist_12_LevelFontSize)

// MARK: 圆角
let kCircularBead_1_2_LevelRadius: CGFloat = 2.0
let kCircularBead_2_4_LevelRadius: CGFloat = 4.0
let kCircularBead_2_13_LevelRadius: CGFloat = 13.0

// MARK: 描边
let kBorderWidth: CGFloat = 1.0 / UIScreen.main.scale

// MARK: --参数判断-----------------------------------------------------------------------

// 移至缓存对象类中
let zh_yes_Login: Bool = true
let zh_no_Login: Bool = false
let zh_yes_RealNameAuthentication: Bool = true
let zh_false_RealNameAuthentication: Bool = false

// MARK: --文案显示-----------------------------------------------------------------------
let loginBUttonTitle = "登录"

// MARK: ALL KEY
/**
 *  请求headers和缓存使用
 **/
let kClientId = "clientId"
let kUserId = "userId"
let kToken = "token"
let kPushRegistrationId = "pushRegistrationId"
