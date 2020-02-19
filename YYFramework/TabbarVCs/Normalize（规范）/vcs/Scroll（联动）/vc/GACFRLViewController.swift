//
//  GACFRLViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/26.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import MJRefresh

class GACFRLViewController: YYBaseTableViewController {
    
    private let topHeight: CGFloat = 350
    private let fixedHeight: CGFloat = 150
    private var isScrollCalender: Bool = false // 滚动日历、刷新
    private var scrollViewDidEndDragging: Bool = false
    private var scrollViewDidEndScrollingAnimation: Bool = false
    private var scrollViewDidEndDecelerating: Bool = false
    
    lazy var calenderView: GASelectedDateCalenderView = {
        let v = GASelectedDateCalenderView(frame: CGRect(x: 0, y: 0, width: self.view.width, height: topHeight))
        v.delegate = self
        return v
    }()
    
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
        
        base_showNavigationView(title: "财富日历")
        
        base_showNavigationView(customerView: navView)
        
        self.dataSource = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 2, 3, 4, 5, 6, 7, 8, 9, 0]
        
        base_initTableView()
    }
    
    override func base_initTableView() {
        self.view.addSubview(tableView)
        
        self.tableView.addSubview(topView)
        self.topView.addSubview(calenderView)
        self.view.addSubview(fixedView)
        
        tableView.yy_register(nibName: GATestViewCell.identifier)
        tableView.frame = CGRect(x: 0, y: kNavigationViewMaxY, width: self.view.bounds.width, height: self.view.bounds.height - kNavigationViewMaxY)
        tableView.contentInset = UIEdgeInsets(top: topHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -topHeight)
        
        // es刷新有bug topView会跳
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.tableView.mj_header?.endRefreshing()
        })
    }
    
}

extension GACFRLViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        // 滑动日历提前return
        if isScrollCalender || self.tableView.mj_header?.isRefreshing ?? false {
            isScrollCalender = false
            self.topView.y = -self.topView.height + (y + self.topView.height)
            return
        }
        
        // 向下滑处理
        if y <= -self.topView.height {
            self.topView.y = -self.topView.height + (y + self.topView.height)
            return
        }
        
        // 保留出固定高度、navView的控制
        if y > -self.view.width / 7 && y != 0 {
            self.topView.y = -self.topView.height + self.view.width / 7 + y
            navView.isHidden = false
        } else {
            navView.isHidden = true
        }
    }
}

extension GACFRLViewController: GASelectedDateCalenderViewDelegate {
    func selectedDateCalenderView_updateViewsFrame(h: CGFloat) {
        isScrollCalender = true 
        if #available(iOS 10.0, *) {
            let t = Timer(fire: Date(), interval: 0.02, repeats: false) { (t) in
                self.topView.height = h
                self.topView.y = -h
                self.calenderView.height = h
                self.tableView.contentInset = UIEdgeInsets(top: h, left: 0, bottom: 0, right: 0)
                self.tableView.contentOffset = CGPoint(x: 0, y: -h)
            }
            RunLoop.main.add(t, forMode: RunLoop.Mode.common)
        } else {
            
        }
    }
}

extension GACFRLViewController {
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
