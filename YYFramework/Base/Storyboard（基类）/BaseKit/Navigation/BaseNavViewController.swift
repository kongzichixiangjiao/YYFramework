//
//  BaseNavViewController.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit
import SnapKit

class BaseNavViewController: BaseViewController {

    var navigationView: NavigationView = NavigationView.xibView()
    private(set) var navigationBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.navigationView)
        self.navigationView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(44)
            make.top.equalTo(self.topLayoutGuide.snp.bottom)
        }
        
        self.navigationView.backButton.addTarget(self, action: #selector(self.backButtonClick), for: .touchUpInside)
        if (self.navigationController?.viewControllers.first == self) {
            self.navigationView.backButton.isHidden = true
        }
    }
    
    @objc func backButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setNavigationBarHidden(_ hidden: Bool, animated flag: Bool = true) -> Void {
        navigationBarHidden = hidden
        navigationView.shadowImageView.isHidden = hidden
        if hidden {
            navigationView.snp.remakeConstraints { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(44)
                make.bottom.equalTo(self.view.snp.top)
            }
        } else {
            navigationView.snp.remakeConstraints { (make) in
                make.left.right.equalTo(0)
                make.height.equalTo(44)
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
            }
        }
        
        if flag {
            UIView.animate(withDuration: 0.35) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    override var title: String? {
        didSet {
            self.navigationView.titleLabel.text = title
        }
    }

}
