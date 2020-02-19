//
//  GAPreferenceOrderingCell.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/19.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

extension GAPreferenceOrderingCell: GAPreferenceOrderingViewDelegate {
    func preferenceOrderingViewClicked(btn: UIButton) {
        menuView.show(models: models, targetView: btn)
        print(preferenceOrderingView.resultTitles ?? [])
    }
}

class GAPreferenceOrderingCell: UITableViewCell {
    
    var menuView: GAPopMenuView!
    var models: [GAPopMenuModel] = []
    
    lazy var preferenceOrderingView: GAPreferenceOrderingView = {
        let v = GAPreferenceOrderingView.loadPreferenceOrderingView()
        v.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 50, height: 34)
        v.delegate = self
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.addSubview(preferenceOrderingView)
        
        _initMenuViewData()
        _initMenuView()
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
    
}
