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

extension AppDelegate {
    
    func flutter_run() {
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
    }
}
