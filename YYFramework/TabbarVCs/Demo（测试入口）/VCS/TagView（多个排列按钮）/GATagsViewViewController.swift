//
//  GATagsViewViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/8.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GATagsViewViewController: GANavViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "Tags")
        
        _initArray()
        self.view.addSubview(tagsView)
    }
    
    var data: [GATagsButtonModel] = []
    
    lazy var tagsView: GATagsView = {
        let model = GATagsViewModel()
        
        let v = GATagsView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 200), btnModels: data, model: model, mType: .more, clickedHandler: {
            [weak self] btn, model, isLast in
            print(btn, model.name, model.isSelected)
        })
        v.delegate = self
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    func _initArray() {
        let m = GATagsButtonModel()
        m.name = "财"
        m.isSelected = false
        
        let m1 = GATagsButtonModel()
        m1.name = "财"
        m1.isSelected = false
        
        let m2 = GATagsButtonModel()
        m2.name = "财经知识"
        m2.isSelected = false
        
        let m3 = GATagsButtonModel()
        m3.name = "财经知识类2"
        m3.isSelected = false
        
        let m4 = GATagsButtonModel()
        m4.name = "财经知识类3"
        m4.isSelected = false
        
        let m5 = GATagsButtonModel()
        m5.name = "财经知识类4"
        m5.isSelected = false
        
        let m6 = GATagsButtonModel()
        m6.name = "财经知识类5"
        m6.isSelected = false
        
        let m7 = GATagsButtonModel()
        m7.name = "财经知识类7"
        m7.isSelected = false
        
//        data = [m, m1, m2, m3, m5, m6]
        data = [m2, m2, m2, m2, m2, m2, m2, m2, m2, m2, m2, m2, m2, m2, m2, m2]
        // , m7, m3, m5, m6, m7, m, m1, m2
    }
    
    @IBAction func show2(_ sender: Any) {
//        let _ = tagsView.reloadViews(btnModels: data, maxRows: 3, clickedHandler: {b,m in
//
//        })
        let _ = tagsView.reloadViewsMoreType(btnModels: data, maxRows: 3, clickedHandler: {b,m,isLast in
            if isLast {
                if m.name == "更多" {
                    let _ = self.tagsView.reloadViewsMoreType(btnModels: self.data, maxRows: 100)
                } else {
                    let _ = self.tagsView.reloadViewsMoreType(btnModels: self.data, maxRows: 3)
                }
            }
        })
    }
    
    @IBAction func showAll(_ sender: Any) {
//        let _ = tagsView.reloadViews(btnModels: data, maxRows: 10, clickedHandler: {b,m in
//
//        })
        
        let _ = tagsView.reloadViewsMoreType(btnModels: data, maxRows: 100, clickedHandler: {b,m,isLast in
            
        })
    }
    
    @IBAction func show1(_ sender: Any) {
//        let _ = tagsView.reloadViews(btnModels: data, maxRows: 1, clickedHandler: {b,m in
//
//        })
        
        let _ = tagsView.reloadViewsMoreType(btnModels: data, maxRows: 1, clickedHandler: {b,m,isLast in
            
        })
    }
    @IBAction func jia(_ sender: Any) {
        let m7 = GATagsButtonModel()
        m7.name = "财经知识类" + String.ga_randomNums(count: 2)
        m7.isSelected = false
        
        data.append(m7)
        let _ = tagsView.reloadViewsMoreType(btnModels: data, maxRows: 100, clickedHandler: {b,m,isLast in
                          
        })
    }
    
    @IBAction func jian(_ sender: Any) {
        data.removeLast()
        let _ = tagsView.reloadViewsMoreType(btnModels: data, maxRows: 100, clickedHandler: {b,m,isLast in
        
        })
    }
    
}


extension GATagsViewViewController: GATagsViewDelegate {
    
    func tagsViewReturnNewRowLastView() -> UIView? {
        return nil 
    }
    
    func tagsViewClickedConfirm(text: String) {
        let m4 = GATagsButtonModel()
        m4.name = text
        m4.isSelected = false
        data.append(m4)
        
        let _ = tagsView.reloadViews(btnModels: data, maxRows: 100, clickedHandler: {b,m,isLast  in
            
        })
    }
    
    
}
