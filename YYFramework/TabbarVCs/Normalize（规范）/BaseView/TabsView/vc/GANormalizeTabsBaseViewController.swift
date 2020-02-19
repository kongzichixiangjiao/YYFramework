//
//  GANormalizeTabsBaseViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/6/11.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GANormalizeTabsBaseViewController: UIViewController {
    lazy var tabsMainView: GANormalizeTabsMainView = {
        let v = GANormalizeTabsMainView(frame: self.view.bounds)
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.addSubview(tabsMainView)
    }
    
    public func initVCS(vcs: [UIViewController], headerView: GANormalizeBaseTabsView) {
        self.tabsMainView.initVCS(vcs: vcs, headerView: headerView)
    }
}

extension GANormalizeTabsBaseViewController: GANormalizeTabsMainViewDelegate  {
    func ga_normalizeTabsMainViewCurrentVC(index: Int, vc: UIViewController) {
        
    }
    
    func ga_normalizeTabsMainViewDidScroll(didIndex: Int, index: Int) {
        
    }
}
