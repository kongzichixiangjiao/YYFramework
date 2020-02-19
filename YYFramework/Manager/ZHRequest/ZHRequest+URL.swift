//
//  ZHRequest+URL.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/30.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

class ZHRequestURL {
    static func baseURL(type: ZHUrlType) -> String {
        // kIsSubmitApplePapa为true或者接口是生产环境
        if kIsSubmitApplePapa || (kDevelopEnvironment_Url == .product && kDevelopEnvironment_H5_Url == .product) {
            return ZHBaseUrlType.product.rawValue
        }
        
        if type == .url {
            switch kDevelopEnvironment_Url {
            case .product:
                return ZHBaseUrlType.product.rawValue
            case .zhunProduct:
                return ZHBaseUrlType.zhunProduct.rawValue
            case .test:
                return ZHBaseUrlType.test.rawValue
            case .other:
                return ZHBaseUrlType.other.rawValue
            }
        } else if type == .h5_url {
            switch kDevelopEnvironment_H5_Url {
            case .product:
                return ZHH5BaseUrlType.product.rawValue
            case .zhunProduct:
                return ZHH5BaseUrlType.zhunProduct.rawValue
            case .test:
                return ZHH5BaseUrlType.test.rawValue
            case .other:
                return ZHH5BaseUrlType.other.rawValue
            }
        } else {
            ZHReuqestLog.errorLog(error: .urlError(message: "base url empty"))
            return ""
        }
    }
}
