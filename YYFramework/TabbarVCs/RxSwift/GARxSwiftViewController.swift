//
//  GARxSwiftViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/9/18.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GARxSwiftViewController: GANavViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        b_showNavigationView(title: "RxSwift")
        b_navigationView.leftButton.isHidden = true
        
        _textRxSwift()
    }
    private func _textRxSwift() {
      
    }
    
    @IBAction func welcome(_ sender: Any) {
        let vc = GARxRootViewController(nibName: "GARxRootViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    deinit {
        #if DEBUG
        print("GARxSwiftViewController")
        #endif
    }
}
