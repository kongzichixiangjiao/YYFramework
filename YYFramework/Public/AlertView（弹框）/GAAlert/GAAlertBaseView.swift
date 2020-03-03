//
//  GAAlertBaseView.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/28.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

enum GAAlertButtonTag: Int {
    case cancle = 0, confirm = 1
}

typealias GAAlertHandler = (_ tag: GAAlertButtonTag, _ model: Any?) -> ()

protocol GAAlertProtocol {
    static func loadView(type: GAAlertType) -> UIView
    var handler: GAAlertHandler! { get set }
}

class GAAlertBaseView: UIView, GAAlertProtocol {
    var handler: GAAlertHandler!
    
    static func loadView(type: GAAlertType) -> UIView {
        switch type {
        case .normal:
            let v = GANormalAlertView.xibView()
            return v
        case .base :
            return GAAlertBaseView()
        }
    }
}

class GAAlertCustomerView: UIView, GAAlertProtocol {
    var handler: GAAlertHandler!
    
    static func loadView(type: GAAlertType) -> UIView {
        switch type {
        case .normal:
            return GAAlertCustomerView()
        case .base :
            return GAAlertCustomerView()
        }
    }
    
}
