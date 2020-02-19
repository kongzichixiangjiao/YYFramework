//
//  GAPopMenuViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/4/9.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAPopMenuViewController: GANavViewController {

    @IBOutlet weak var b: UIButton!
    
    var menuView: GAPopMenuView!
    var models: [GAPopMenuModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "PopMenu")
        
        
        let model = GAPopMenuModel()
        model.title = "123"

        let model1 = GAPopMenuModel()
        model1.title = "aaaaa"
        models = [model1, model]

        menuView = GAPopMenuView(models: models, targetView: b, cellHeight: 40, cellWidth: 200, handler: {
            [weak self] row, targetView  in
            if let weakSelf = self {
                weakSelf.b.setTitle(weakSelf.models[row].title, for: .normal)
            }
        })
    }
    
    @IBAction func ac(_ sender: Any) {
        menuView.show(models: models, targetView: b)
    }
    
    deinit {
        print("deinit GAPopMenuViewController")
    }
}
