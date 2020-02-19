//
//  GATestJsonViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/3/11.
//  Copyright © 2019 houjianan. All rights reserved.
//  测试数据生成模型

import UIKit

class GATestJsonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func lookAction(_ sender: UIButton) {
        GASimulationDataManager.share.ga_simulationRequest(fileName: "testJson", macName: "houjianan", inheritClass: "HandyJSON", resultHandler: { (dic) in
            
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func createModelClass(_ sender: Any) {
        GASimulationDataManager.share.writeToFile(dic:["":""], className: "NewClass", inheritClass: "HandyJSON")
    }
    
}

