//
//  ZHRequest+Log.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/30.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

class ZHReuqestLog {
    
    static func errorLog(error: ZHReuqestError) {
        #if DEBUG
        switch error {
        case .codeError(let message):
            print("ZHReuqestLog - codeError: ", message)
            break
        case .noNetwork(let message):
            print("ZHReuqestLog - noNetwork: ", message)
            break
        case .valueError(let message):
            print("ZHReuqestLog - valueError: ", message)
            break
        case .urlError(let message):
            print("ZHReuqestLog - urlError: ", message)
            break
        case .resultError(let message):
            print("ZHReuqestLog - resultError: ", message)
            break
        case .failedError(let message):
            print("ZHReuqestLog - failedError: ", message)
        case .cancleRequestError(let message):
            print("ZHReuqestLog - cancleRequestError: ", message)
        }
        #endif 
    }
    
}

