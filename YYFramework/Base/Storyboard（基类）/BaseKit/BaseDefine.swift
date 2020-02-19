//
//  BaseDefine.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

func DLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent) \(method) \(line): \(message)")
    #endif
}

var MainScreenBounds: CGRect {
    return UIScreen.main.bounds
}

var MainScreenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

var MainScreenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}

var AppBounds: CGRect {
    return UIApplication.shared.delegate?.window??.bounds ?? CGRect()
}

var APPWidth: CGFloat {
    return UIApplication.shared.delegate?.window??.width ?? 0
}

var APPHeight: CGFloat {
    return UIApplication.shared.delegate?.window??.height ?? 0
}

var SafeTopHeight: CGFloat {
    if #available(iOS 11.0, *) {
        guard let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
            return 20
        }
        return max(20, safeAreaInsets.top)
    } else {
        return 20
    }
}

var SafeBottomHeight: CGFloat {
    if #available(iOS 11.0, *) {
        guard let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
            return 0
        }
        return safeAreaInsets.bottom
    } else {
        return 0
    }
}

let SysVersion = UIDevice.current.systemVersion
let AppVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
let AppBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

let DeviceWidth = min(MainScreenWidth, MainScreenHeight)
let DeviceHeight = max(MainScreenWidth, MainScreenHeight)
let DeviceScale = UIScreen.main.scale

let OnePx = 1.0/DeviceScale

