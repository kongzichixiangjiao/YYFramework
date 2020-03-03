//
//  GAAlertView.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/27.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

class GANormalAlertView: GAAlertBaseView {
    
    @IBAction func cancle(_ sender: Any) {
        handler(.cancle, "")
    }
}
