//
//  NotificationCenter+Extension.swift
//  GARxSwift
//
//  Created by houjianan on 2020/3/12.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

extension NotificationCenter {
    static func ga_post(customeNotification name: Notification.Name, object: Any? = nil){
        NotificationCenter.default.post(name: name, object: object)
    }
}

