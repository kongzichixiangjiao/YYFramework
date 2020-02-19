//
//  AppDelegate+Bugly.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/19.
//  Copyright © 2020 houjianan. All rights reserved.
//  Bugly热修复

import Foundation
//import BuglyHotfix

extension AppDelegate {
    func bugly_Config() {
        _configBugly()
    }

    private func _configBugly() {
//        let buglyConfig = BuglyConfig()
//        buglyConfig.debugMode = true
//        buglyConfig.reportLogLevel = .info
//        Bugly.start(withAppId: "6c133364ec",config:buglyConfig)
//
//        JPEngine.handleException { (msg) in
//            let exception = NSException(name: NSExceptionName(rawValue: "Hotfix Exception"), reason: msg, userInfo: nil)
//            Bugly.report(exception)
//        }
//
//        BuglyMender.shared().checkRemoteConfig { (event:BuglyHotfixEvent, info:[AnyHashable : Any]?) in
//            if (event == BuglyHotfixEvent.patchValid || event == BuglyHotfixEvent.newPatch) {
//                let patchDirectory = BuglyMender.shared().patchDirectory() as NSString
//                let patchFileName = "main.js"
//                let patchFilePath = patchDirectory.appendingPathComponent(patchFileName)
//                if (FileManager.default.fileExists(atPath: patchFilePath) && JPEngine.evaluateScript(withPath: patchFilePath) != nil) {
//                    BuglyLog.level(.info, logs: "evaluateScript success")
//                    BuglyMender.shared().report(.activeSucess)
//                }else {
//                    BuglyLog.level(.error, logs: "evaluateScript fail")
//                    BuglyMender.shared().report(.activeFail)
//                }
//            }
//        }
    }
}
