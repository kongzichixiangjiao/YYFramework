//
//  NotificationName+Extension.swift
//  YYFramework
//
//  Created by houjianan on 2019/9/24.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

extension Notification.Name {
    /// 使用命名空间的方式
    public struct SocketTask {
        public static let connectFailure = Notification.Name(rawValue: "connectFailure")
        public static let connectSuccess = Notification.Name(rawValue: "connectSuccess")
  }
    
}
