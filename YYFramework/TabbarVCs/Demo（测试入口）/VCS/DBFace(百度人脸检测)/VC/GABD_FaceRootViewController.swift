//
//  GABD_FaceRootViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/29.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GABD_FaceRootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func go(_ sender: Any) {
//        let vc = DetectionViewController()
        let vc = GA_BDFaceViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
