//
//  AppDelegate+MagicalRecord.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/24.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation
import MagicalRecord

extension AppDelegate {
    
    func mrCoreData_init() {
        MagicalRecord.setupCoreDataStack()
    }
}
