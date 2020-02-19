//
//  GACalenderController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderController5: YYBaseTableViewController {
    
    let tableViewHeaderHeight: CGFloat = 400
    var offsetType: ScrollOffsetType = .min
    var topHeight: CGFloat = 100
    var scrollMaxY: CGFloat = 20
    var currentScrollDirection: GAScrollDirection = .normal
    
    lazy var tableViewHeaderView: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.width, height: tableViewHeaderHeight)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var fixedView: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: kNavigationHeight, width: self.view.width, height: kNavigationViewMaxY)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var topView: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: -topHeight, width: self.view.width, height: topHeight)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var mainScrollView: GAScrollView = {
        let v = GAScrollView()
        v.delegate = self
        v.tag = 1
        v.frame = self.tableViewHeaderView.bounds
        v.backgroundColor = UIColor.randomColor()
        v.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView(title: "选择日期", isShow: true)
        _initViews()
        base_initTableView()
    }
    
    private func _initViews() {
        self.tableView.addSubview(topView)
        topView.text = "topView"
        
        self.view.addSubview(fixedView)
        fixedView.text = "fixedView"
        
        tableViewHeaderView.addSubview(mainScrollView)
    }
    
    override func base_initTableView() {
        super.base_initTableView()
        
        tableView.yy_register(nibName: GACalenderListCell.identifier)
        tableView.yy_register(nibName: GACalenderContentCell.identifier)
        
        tableViewHeaderView.text = "tableViewHeaderView"
        tableView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = tableViewHeaderView
        tableView.sectionHeaderHeight = tableViewHeaderHeight
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false 
        }
        tableView.contentInset = UIEdgeInsets(top: topHeight, left: 0, bottom: 0, right: 0)
        
        tableView.tag = 2
    }
    
}

extension GACalenderController5 {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return kScreenHeight - tableViewHeaderHeight
//            return 100 * 40
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.ga_dequeueReusableCell(cellClass: GACalenderContentCell.self)
            cell.currentScrollDirection = currentScrollDirection
            cell.vc5 = self
            return cell
        }
        let cell = tableView.ga_dequeueReusableCell(cellClass: GACalenderListCell.self)
        cell.l.text = String(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
}

extension GACalenderController5 {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        _ = scrollView.tag
        print(y)
        if (y >= (scrollView.contentSize.height - scrollView.height - 0.5)) {
            self.offsetType = .max
        } else if (y <= 0) {
            self.offsetType = .min
        } else {
            self.offsetType = .center
        }
        
        if (y - self.scrollMaxY > 0) {
            self.scrollMaxY = y
            print("up")
            currentScrollDirection = .up
        } else if (self.scrollMaxY - y > 0) {
            self.scrollMaxY = y
            print("down")
            currentScrollDirection = .down
        }
        
//        if tag == 2 {
//            if y > 200 {
//                tableView.contentOffset = CGPoint(x: 0, y: 200)
//                return
//            }
//        }
        //        tableView.contentOffset = CGPoint(x: 0, y: y)
        //        mainScrollView.contentOffset = CGPoint(x: 0, y: y)
    }
}
