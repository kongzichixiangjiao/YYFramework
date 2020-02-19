//
//  GACalenderController1.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderController1: YYBaseTableViewController {
    var tableViewHeightLayout: NSLayoutConstraint!
    var tableViewTopLayout: NSLayoutConstraint!
    var calenderViewHeight: CGFloat = 600
    var panTranslationY: CGFloat = 0
    var panTranslationTempY: CGFloat = 0
    
    lazy var calenderView: GASelectedDateCalenderView = {
        let v = GASelectedDateCalenderView(frame: CGRect(x: 0, y: kNavigationViewMaxY, width: self.view.width, height: 300))
        v.delegate = self
        v.isUserInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(p:)))
        v.addGestureRecognizer(pan)
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView(title: "选择日期", isShow: true)
        
        self.view.addSubview(calenderView)
        calenderViewHeight = calenderView.height
        
        tableView.scrollWasEnabled = false
        
        base_initTableView()
    }
    
    override func base_initTableView() {
        
        self.view.addSubview(tableView)
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))

        if isShowTopSave {
            if #available(iOS 11.0, *) {
                tableViewTopLayout = NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: calenderViewHeight + kNavigationViewMaxY)
                self.view.addConstraint(tableViewTopLayout)
            } else {
                tableViewTopLayout = NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: calenderViewHeight + kNavigationViewMaxY)
                self.view.addConstraint(tableViewTopLayout)
            }
        } else {
            tableViewTopLayout = NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: calenderViewHeight + kNavigationViewMaxY)
            self.view.addConstraint(tableViewTopLayout)
        }
        
        tableViewHeightLayout = NSLayoutConstraint(item: self.tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.view.frame.size.height - kNavigationViewMaxY - (isShowTabbarView ? kTabBarHeight : 0))
        self.view.addConstraint(tableViewHeightLayout)
        
        tableView.yy_register(nibName: GACalenderListCell.identifier)
    }
    
    @objc func pan(p: UIPanGestureRecognizer) {
        panTranslationY = p.translation(in: calenderView).y + panTranslationTempY
        print("panTranslationY = ", panTranslationY)
        print(p.translation(in: calenderView).y)
        if p.state == .ended {
            UIView.animate(withDuration: TimeInterval(self.tableView.contentOffset.y / kScreenHeight)) {
                self.tableView.contentOffset = CGPoint(x: 0, y: 0)
            }
            if tableView.contentOffset.y >= 0 {
                panTranslationTempY = p.translation(in: calenderView).y
            }
            print("end - panTranslationTempY = ", panTranslationTempY)
            print("end - tableViewTopLayout.constant = ", tableViewTopLayout.constant)
        } else if p.state == .changed {
            if panTranslationY > 0 {
                panTranslationY = p.translation(in: calenderView).y
                if tableViewTopLayout.constant + panTranslationY > calenderViewHeight + kNavigationViewMaxY {
                    tableViewTopLayout.constant = calenderViewHeight+kNavigationViewMaxY
                    // scrollView向下滑动
                    tableView.contentOffset = CGPoint(x: 0, y: -panTranslationY + panTranslationTempY)
                    return
                }
            }
            tableViewTopLayout.constant = calenderViewHeight + kNavigationViewMaxY - tableView.contentOffset.y + panTranslationY
            print("changed - panTranslationY = ", panTranslationY)
            print("tableViewTopLayout.constant = ", tableViewTopLayout.constant)
        } else {
            print("begin - tableViewTopLayout.constant = ", tableViewTopLayout.constant)
            print("begin - panTranslationY = ", panTranslationY)
        }
    }
}

extension GACalenderController1 {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if calenderViewHeight - y <= GACalenderControlHeaderView.height + GACalenderWeekHeaderView.height + GACalenderMonthCell.height {
            tableViewTopLayout.constant = kNavigationViewMaxY + GACalenderControlHeaderView.height + GACalenderWeekHeaderView.height + GACalenderMonthCell.height
            return
        }
        print("y = ", y)
        tableViewTopLayout.constant = calenderViewHeight+kNavigationViewMaxY - y
    }
}

extension GACalenderController1: GASelectedDateCalenderViewDelegate {
    func selectedDateCalenderView_updateViewsFrame(h: CGFloat) {
        calenderViewHeight = h
        scrollViewDidScroll(tableView)
    }
}

extension GACalenderController1 {
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
