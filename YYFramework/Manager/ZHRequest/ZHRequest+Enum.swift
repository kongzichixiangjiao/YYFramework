//
//  ZHRequest+Enum.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/30.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

enum ZHReuqestError: Error {
    case noNetwork(message: String)
    case valueError(message: String)
    case codeError(message: String)
    case urlError(message: String)
    case resultError(message: Any)
    case failedError(message: String)
    case cancleRequestError(message: String)
}

enum ZHImageType: String {
    case jpg = "jpg", png = "png", jpeg = "jpeg", gif = "gif"
}

// 多域名在此增加 需要修改ZHRequestURL
enum ZHUrlType: String {
    case url = "url", h5_url = "h5_url"
}

enum ZHRequestAppName: String {
    case normal = ""
    case px_jf = "普信金服"
    case px_cfgw = "普信财富顾问"
    case ly_cffw = "朗瀛财富服务"
    case ly_lcs = "朗瀛理财师"
    case test = "框框"
}

enum ZHReuqestErrorCode: String {
    case noNet = "-c2017", formatError = "-c2018", failure = "-c2019", specialCode = "-c2020", cancleCode = "-c2021"
}
