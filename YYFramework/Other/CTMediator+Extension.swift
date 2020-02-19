//
//  CTMediator+Extension.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/16.
//  Copyright © 2019年 houjianan. All rights reserved.
//
import Foundation
import UIKit
import CTMediator

//@objc(Target_One)
//class Target_One: NSObject {
//
//    @objc
//    func Action_ToOneViewController(params: [NSString: AnyObject]?) -> UIViewController? {
//        let vc = OneViewController()
//        if let model = params?["model"] as? Model {
//            vc.model = model
//        }
//        return vc
//    }
//}

extension CTMediator {
    
    func sl_2OneViewController(_ params: [NSString: AnyObject]?) -> UIViewController? {
        
        guard let vc = performTarget("GAMineDetailsViewController", action: "GAMineDetailsViewController", params: params, shouldCacheTarget: false) as? UIViewController else {
            print("未找到GAMineDetailsViewController")
            return nil
        }
        return vc
    }
}

