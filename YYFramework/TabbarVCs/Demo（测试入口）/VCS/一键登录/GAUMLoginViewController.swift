//
//  GAUMLoginViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/3/13.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

class GAUMLoginVeiwController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
        _request()
    }
    
    private func _initViews() {
        
    }
    
    
    private func _request() {
        let s = "TAhWw4xyXQx/pSlq19k//J/JaXGODb+skyX1iHSoMC+kbSdfjHGh6RPkeaJ532IJq+Ye6TrobzrWt8aumuyWrYA6SdER/BctT/t/T3P3r3llv+cUuhN+O9e8ad+iLxdnsG7AniAmbfqLX3P+pACetl4QpYpjQM5/cfaOOHMo05jcePK5OSUgzbsOU65780ER9AFNZFXPZHCXJ5IKVI8U2cQ4csbu3M4r5N0PQr/Oanc9xnHUCd7H8w=="
        UMCommonHandler.setVerifySDKInfo(s) { (resultDic) in
            print(resultDic)
            UMCommonHandler.checkEnvAvailable { (resultDic) in
                print(resultDic ?? "")
                UMCommonHandler.accelerateLoginPage(withTimeout: 20) { (resultDic) in
                    print(resultDic)
                    let model = UMCustomModel.init()
                    model.logoImage = UIImage(named: "page_control_point")!
                    model.sloganText = NSAttributedString(string: "一切都很好")
                    UMCommonHandler.getLoginToken(withTimeout: 20, controller: self, model: model) { (resultDic) in
                        print(resultDic)
                        _ = resultDic["token"]
                    }
                }
            }
        }
    }
    
}
