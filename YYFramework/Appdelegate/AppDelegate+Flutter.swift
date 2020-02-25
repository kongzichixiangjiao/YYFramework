//
//  AppDelegate+Flutter.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/20.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation
import Flutter
import FlutterPluginRegistrant // Used to connect plugins.

var kFlutterEngineKey: UInt = 20022301

extension AppDelegate {
    
    func flutter_run() {
        flutterEngine = FlutterEngine(name: "my flutter engine")
        
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine)
    }
    
    var scrollWasEnabled: Bool {
        set {
            objc_setAssociatedObject(self, &UITableView.k_t_ScrollWasEnabledKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &UITableView.k_t_ScrollWasEnabledKey) as! Bool
        }
    }
    
    var flutterEngine: FlutterEngine {
        set {
            objc_setAssociatedObject(self, &kFlutterEngineKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &kFlutterEngineKey) as! FlutterEngine
        }
    }
}

