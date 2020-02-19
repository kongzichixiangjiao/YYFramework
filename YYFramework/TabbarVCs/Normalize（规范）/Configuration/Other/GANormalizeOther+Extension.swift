//
//  GANormalizeOther+Extension.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/25.
//  Copyright © 2019年 houjianan. All rights reserved.
//

/*
 *  机型对应启动图、16进制颜色、设备机型
 */

import Foundation
import UIKit

extension CGFloat {
    static func normalize_useLaunchImageType() -> GALaunchImageType {
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

extension String {
    var normalize_color0X: UIColor! {
        var cString:String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    func normalize_color0X(_ alpha: CGFloat) -> UIColor {
        var cString:String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha))
    }
}

// https://www.theiphonewiki.com/wiki/Models
public extension UIDevice {
    
    var normalize_modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch 5"
        case "iPod7,1":  return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":  return "iPhone 5s"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1", "iPhone9,3":  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":  return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,6", "iPhone11,4": return "iPhone XS Max"
            
        case "iPad1,1": return "iPad"
        case "iPad1,2": return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":  return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":  return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":  return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
            
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":  return "Apple TV 4"
            
        case "i386", "x86_64":  return "Simulator"
            
        default:  return identifier
        }
    }
    
}

enum GANormalizeDeviceType: String {
    case none = "",
    
    iPodTouch1 = "iPod Touch 1",
    iPodTouch2 = "iPod Touch 2",
    iPodTouch3 = "iPod Touch 3",
    iPodTouch4 = "iPod Touch 4",
    iPodTouch5 = "iPod Touch 5",
    iPodTouch6 = "iPod Touch 6",
    
    iPhone4 = "iPhone 4",
    iPhone4s = "iPhone 4s",
    iPhone5 = "iPhone 5",
    iPhone5c = "iPhone 5c",
    iPhone5s = "iPhone 5s",
    iPhone6 = "iPhone 6",
    iPhone6Plus = "iPhone 6 Plus",
    iPhone6s = "iPhone 6s",
    iPhone6sPlus = "iPhone 6s Plus",
    iPhoneSE = "iPhone SE",
    iPhone7 = "iPhone 7",
    iPhone7Plus = "iPhone 7 Plus",
    iPhone8 = "iPhone 8",
    iPhone8Plus = "iPhone 8 Plus",
    iPhoneX = "iPhone X",
    iPhoneXR = "iPhone XR",
    iPhoneXS = "iPhone XS",
    iPhoneXSMax = "iPhone XS Max",
    
    iPad = "iPad",
    iPad3G = "iPad 3G",
    iPad2 = "iPad 2",
    iPadMini = "iPad Mini",
    iPad3 = "iPad 3",
    iPad4 = "iPad 4",
    iPadAir = "iPad Air",
    iPadMini2 = "iPad Mini 2",
    iPadMini3 = "iPad Mini 3",
    iPadMini4 = "iPad Mini 4",
    iPadAir2 = "iPad Air 2",
    iPadPro9p7 = "iPad Pro 9.7",
    iPadPro12p9 = "iPad Pro 12.9",
    
    AppleTV2 = "Apple TV 2",
    AppleTV3 = "Apple TV 3",
    AppleTV4 = "Apple TV 4",
    
    Simulator = "Simulator"
    
}
