//
//  GAZFBScrollViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/19.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import MJRefresh

class GAZFBScrollViewController: YYBaseTableViewController {
    
    private let topHeight: CGFloat = 350
    private let fixedHeight: CGFloat = 150
    
    lazy var topView: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: -topHeight, width: self.view.width, height: topHeight)
        return v
    }()
    
    lazy var fixedView: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: kNavigationViewMaxY, width: self.view.width, height: fixedHeight)
        v.text = "fixedView"
        v.isHidden = true
        return v
    }()
    
    lazy var navView: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.width, height: kNavigationViewMaxY)
        v.text = "navView"
        v.isHidden = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView(title: "支付宝首页")
        
        base_showNavigationView(customerView: navView)
        
        self.dataSource = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        
        base_initTableView()
    }
    
    override func base_initTableView() {
        self.view.addSubview(tableView)
        topView.text = "topView"
        
        self.tableView.addSubview(topView)
        self.view.addSubview(fixedView)
        
        tableView.yy_register(nibName: GATestViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: topHeight, left: 0, bottom: 0, right: 0)
        tableView.frame = CGRect(x: 0, y: kNavigationViewMaxY, width: self.view.bounds.width, height: self.view.bounds.height - kNavigationViewMaxY)
        tableView.contentOffset = CGPoint(x: 0, y: -topHeight)
        
        // es刷新有bug topView会跳
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.tableView.mj_header?.endRefreshing()
        })
    }
    
}

extension GAZFBScrollViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if y <= -self.topHeight {
            self.topView.y = -topHeight + (y + topHeight)
            return
        }
        
        if y > -fixedHeight {
            self.topView.y = -topHeight + fixedHeight + y
            navView.isHidden = false
        } else {
            navView.isHidden = true
        }
    }
}

extension GAZFBScrollViewController {
    // 冲突
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let v = GADemoView(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
//        v.text = "viewForHeaderInSection"
//        return v
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GATestViewCell.self)
        cell.l.text = String(self.dataSource[indexPath.row] as! Int)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
}
