//
//  GACalenderController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderController4: YYBaseTableViewController {
    
    let tableViewHeaderHeight: CGFloat = 100
    var offsetType: ScrollOffsetType = .min
    var topHeight: CGFloat = 100
    
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
        
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: kNavigationViewMaxY, width: self.view.width, height: topHeight)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.text = "假view"
        self.view.addSubview(v)
        
        let v1 = GADemoView()
        v1.frame = CGRect(x: 0, y: kNavigationViewMaxY + topHeight, width: self.view.width, height: tableViewHeaderHeight)
        v1.translatesAutoresizingMaskIntoConstraints = false
        v1.text = "假view1"
        self.view.addSubview(v1)
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
    }
    
}

extension GACalenderController4: GACalenderControlHeaderViewDelegate {
    func calenderControlHeaderView_left() {
        
    }
    
    func calenderControlHeaderView_right() {
        
    }
    
    func calenderControlHeaderView_title() {
        
    }
}

extension GACalenderController4: GASelectedDateCalenderViewDelegate {
    func selectedDateCalenderView_updateViewsFrame(h: CGFloat) {
        tableView.sectionHeaderHeight = h
        tableView.reloadData()
    }
}

extension GACalenderController4 {
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let v = GADemoView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
    //        v.text = "viewForHeaderInSection"
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 100 * 40
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.ga_dequeueReusableCell(cellClass: GACalenderContentCell.self)
            cell.vc4 = self
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

extension GACalenderController4 {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        print(y)
        self.topView.isHidden = y < -topHeight
        self.tableViewHeaderView.isHidden =  y < -topHeight
        
//        if y >= 0 {
//            tableView.contentOffset = CGPoint.zero
//            self.offsetType = .max
////            return
//        }
        
        if y >= (scrollView.contentSize.height - scrollView.height - 0.5) {
            self.offsetType = .max
        } else if (y <= 0) {
            self.offsetType = .min
        } else {
            self.offsetType = .center
        }
    }
}
