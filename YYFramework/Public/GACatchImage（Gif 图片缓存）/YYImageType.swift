//
//  GAImageType.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/14.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import Foundation

public enum GAImageDataType: String {
    case gif    = "gif"
    case png    = "png"
    case jpeg   = "jpeg"
    case tiff   = "tiff"
    case defaultType
}

class GAImageType {
    static func checkDataType(data: Data?) -> GAImageDataType {
        guard data != nil else {
            return .defaultType
        }
        let c = data![0]
        switch (c) {
        case 0xFF:
            return .jpeg
        case 0x89:
            return .png
        case 0x47:
            return .gif
        case 0x49, 0x4D:
            return .tiff
        default:
            return .defaultType
        }
    }
}

