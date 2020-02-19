//
//  GASearchViewViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/13.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import SnapKit

class GASearchViewViewController: GANavViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        b_showNavigationView(title: "搜索框")
        
        let v = "GASearchView".xibLoadView() as! GASearchView
        v.isShowCancleButton = false
        self.view.addSubview(v)
        
        v.snp.makeConstraints { (make) in
            make.top.equalTo(200)
            make.left.right.equalTo(0)
            make.height.equalTo(35)
        }
        
        let v2 = "GASearchView".xibLoadView() as! GASearchView
        v2.isShowCancleButton = true 
        self.view.addSubview(v2)
        
        v2.snp.makeConstraints { (make) in
            make.top.equalTo(300)
            make.left.right.equalTo(0)
            make.height.equalTo(35)
        }
        
    }

}
