//
//  GANormalizeBaseProtocol.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/13.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation

// HUD
protocol GANormalizeBaseHUDProtocol {
    func base_showHUD(message: String)
    func base_dismissHUD()
}

protocol GANormalizeBaseToastProtocol {
    func base_showToast(message: String)
    func base_hideToast()
}
