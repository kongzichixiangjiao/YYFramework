//
//  GAPreferenceOrderingViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/15.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import SnapKit

extension GAPreferenceOrderingViewController: GAPreferenceOrderingViewDelegate {
    func preferenceOrderingViewClicked(btn: UIButton) {
        menuView.show(models: models, targetView: btn)
        print(preferenceOrderingView.resultTitles ?? [])
    }
}

class GAPreferenceOrderingViewController: GANavViewController {
    var menuView: GAPopMenuView!
    var models: [GAPopMenuModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var preferenceOrderingView: GAPreferenceOrderingView = {
        let v = GAPreferenceOrderingView.loadPreferenceOrderingView()
        v.frame = CGRect(x: 25, y: 100, width: UIScreen.main.bounds.width - 50, height: 34)
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "偏好排序", isShow: true)
        
        _initTableView()
        _initPreferenceOrderingView()
        _initMenuViewData()
        _initMenuView()
    }
    
    private func _initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.yy_register(nibName: GAPreferenceOrderingCell.identifier)
    }
    
    private func _initPreferenceOrderingView() {
        self.view.addSubview(preferenceOrderingView)
        preferenceOrderingView.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.top.equalTo(100)
            make.width.equalTo(UIScreen.main.bounds.width - 50)
            make.height.equalTo(34)
        }
        
        preferenceOrderingView.layoutIfNeeded()
    }
    
    private func _initMenuViewData() {
        let model = GAPopMenuModel()
        model.title = "风险"
        
        let model1 = GAPopMenuModel()
        model1.title = "流动性"
        
        let m2 = GAPopMenuModel()
        m2.title = "收益"
        
        models = [model, model1, m2]
    }
    
    private func _initMenuView() {
        menuView = GAPopMenuView(models: models, targetView: preferenceOrderingView.b1, cellHeight: 40, cellWidth: preferenceOrderingView.b1.bounds.width, handler: { (row, targetView) in
            self.preferenceOrderingView.setUpViews(b: (targetView as! UIButton), t: self.models[row].title)
        })
    }
    
    deinit {
        print("deinit GAPreferenceOrderingViewController")
    }
}

extension GAPreferenceOrderingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GAPreferenceOrderingCell.self)
        
        return cell
    }
    
}
