//
//  YYBaseTableViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  tableView基类

/*
 override func viewDidLoad() {
 super.viewDidLoad()
 
 base_showNavigationView(title: "list", isShow: false)
 base_initTableView()
 }
 
 override func base_initTableView() {
 isShowTabbarView = true
 super.base_initTableView()
 tableView.yy_register(nibName: GATestViewCell.identifier)
 }
 */

import UIKit

class YYBaseTableViewController: YYBaseViewController {
    
    // 防止重复点击
    private var preventRepeatClicked: Bool = false
    
    public var dataSource: [Any] = []
    
    public var isShowTabbarView: Bool = false
    
    public var isShowTopSave: Bool = true
    
    public var isCancleX: Bool = false
    
    public var tableViewStyle: UITableView.Style = .plain
    
    public var b_editingStyle: UITableViewCell.EditingStyle = .none // 默认不能编辑
    
    // 赋值不考虑导航栏
    open var tableViewAllSpace: UIEdgeInsets = UIEdgeInsets.zero {
        didSet {
            
        }
    }
    
    lazy var tableView: GATableView = {
        let t = GATableView(frame: CGRect.zero, style: tableViewStyle)
        t.delegate = self
        t.dataSource = self
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        t.tableFooterView = UIView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    open func base_updateTableViewFrame() {
        
    }
    
    fileprivate func initFooterView() -> GABaseTableViewFooterView {
        let footerView = Bundle.main.loadNibNamed("GABaseTableViewFooterView", owner: self, options: nil)?.last as! GABaseTableViewFooterView
        return footerView
    }
    
    open func footerView() {
        //        self.tableView.tableFooterView = initFooterView()
    }
    
    open func registerClassWithIdentifier(_ identifier: String) {
        tableView.register(NSClassFromString(identifier), forCellReuseIdentifier: identifier)
    }
    
    open func registerClassCell(_ identifiers: [String]) {
        for identifier in identifiers {
            tableView.register(NSClassFromString(identifier), forCellReuseIdentifier: identifier)
        }
    }
    
    open func registerNibWithIdentifier(_ identifier: String) {
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    open func registerNibCell(_ identifiers: [String]) {
        for identifier in identifiers {
            tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func base_initTableView() {
        self.view.addSubview(tableView)
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        if isShowTopSave {
            if #available(iOS 11.0, *) {
                self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: kNavigationViewMaxY))
            } else {
                self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: kNavigationViewMaxY))
            }
        } else {
            self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: kNavigationViewMaxY))
        }
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.view.frame.size.height - kNavigationViewMaxY - (isShowTabbarView ? kTabBarHeight : 0)))
    }
    
    override func updateNavigationViewLayout(type: UIInterfaceOrientation) {
        super.updateNavigationViewLayout(type: type)
        
        for constraint in self.view.constraints {
            if let t = constraint.firstItem as? UITableView {
                if t == tableView {
                    if constraint.firstAttribute == .height {
                        if type.isPortrait {
                            constraint.constant = (UIScreen.main.bounds.size.height < UIScreen.main.bounds.size.width ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height) - kNavigationViewMaxY - (isShowTabbarView ? kTabBarHeight : 0)
                        } else {
                            constraint.constant = (UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width ? UIScreen.main.bounds.size.width : UIScreen.main.bounds.size.height) - (isShowNavigationView ? kLandscapeNavigationHeight : 0) - (isShowTabbarView ? kLandscapeTabBarHeight : 0)
                        }
                    }
                    if constraint.firstAttribute == .top {
                        constraint.constant = isShowNavigationView ? (kNavigationViewMaxY) : 0
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func preventRepeatClicked(b: Bool) {
        preventRepeatClicked = b
    }
}

extension YYBaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !preventRepeatClicked {
            preventRepeatClicked = true
            tableView.deselectRow(at: indexPath, animated: true)
            self.perform(#selector(preventRepeatClicked(b:)), with: false, afterDelay: 1.0)
        } else {
            return
        }
    }
}


extension YYBaseTableViewController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return b_editingStyle
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        } else if editingStyle == .insert {
        } else {
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
}
