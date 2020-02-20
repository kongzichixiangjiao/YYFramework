//
//  YYCardIOViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/7.
//  Copyright © 2018年 houjianan. All rights reserved.
//  百度人脸识别

import UIKit
//import AipOcrSdk

class YYCardIOViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.white
//        AipOcrService.shard().auth(withAK: "DKSLqUGSi4NIECYE2BTPA6W8", andSK: "i2xYW3UsHUqI0oYohvdal4QCipoYBzRm")
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @IBAction func idCardFront(_ sender: Any) {
//        let vc = AipCaptureCardVC.viewController(with: .idCardFont) { (img) in
//            AipOcrService.shard().detectIdCardFront(from: img, withOptions: nil, successHandler: { (source) in
//                self.showDetail(text: String(describing: source!))
//            }, failHandler: { (error) in
//                self.showDetail(text: String(describing: error!))
//            })
//        }
//        self.present(vc!, animated: true, completion: nil)
//    }
//
//    @IBAction func idCardBack(_ sender: Any) {
//        let vc = AipCaptureCardVC.viewController(with: .idCardBack) { (img) in
//            AipOcrService.shard().detectIdCardBack(from: img, withOptions: nil, successHandler: { (source) in
//                self.showDetail(text: String(describing: source!))
//            }, failHandler: { (error) in
//                self.showDetail(text: String(describing: error!))
//            })
//        }
//        self.present(vc!, animated: true, completion: nil)
//    }
//
//    @IBAction func bankCard(_ sender: Any) {
//        let vc = AipCaptureCardVC.viewController(with: .bankCard) {
//            [weak self] img in
//            if let weakSelf = self {
//                AipOcrService.shard().detectBankCard(from: img, successHandler: { (source) in
//                    weakSelf.showDetail(text: String(describing: source!))
//                }, failHandler: { (error) in
//                    weakSelf.showDetail(text: String(describing: error!))
//                })
//            }
//        }
//        self.present(vc!, animated: true, completion: nil)
//    }
//
//    func showDetail(text: String) {
//        DispatchQueue.main.async {
//            self.resultLabel.text = text
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
    
}
