//
//  GACalenderController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderController2: YYBaseTableViewController {
    
    lazy var calenderView: GASelectedDateCalenderView = {
        let v = GASelectedDateCalenderView(frame: CGRect(x: 0, y: -600, width: self.view.width, height: 600))
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView(title: "选择日期", isShow: true)
        
        base_initTableView()
    }
    
    override func base_initTableView() {
        super.base_initTableView()
        
        tableView.yy_register(nibName: GACalenderListCell.identifier)
        
        tableView.addSubview(calenderView)
        calenderView.frame = CGRect(x: 0, y: -calenderView.height, width: self.view.width, height: calenderView.height)
        tableView.contentInset = UIEdgeInsets(top: calenderView.height, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
}

extension GACalenderController2: GASelectedDateCalenderViewDelegate {
    func selectedDateCalenderView_updateViewsFrame(h: CGFloat) {
        tableView.contentInset = UIEdgeInsets(top: h, left: 0, bottom: 0, right: 0)
        calenderView.frame = CGRect(x: 0, y: -h, width: self.view.width, height: h)
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        tableView.reloadData()
    }
}

extension GACalenderController2 {
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let v = UIView()
//        v.frame = CGRect(x: 0, y: 0, width: 400, height: 100)
//        v.backgroundColor = UIColor.randomColor()
//        return v
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 100
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GACalenderListCell.self)
        cell.l.text = String(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
}
