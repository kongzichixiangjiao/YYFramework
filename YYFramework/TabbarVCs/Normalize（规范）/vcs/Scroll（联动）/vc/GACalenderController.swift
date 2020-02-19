//
//  GACalenderController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

enum ScrollOffsetType: Int {
    case center = 0, min = 1, max = 2, other = 3, centerTop = 4
}
class GACalenderController: YYBaseTableViewController {
    
    var tableViewHeightLayout: NSLayoutConstraint!
    var tableViewTopLayout: NSLayoutConstraint!
    var offsetType: ScrollOffsetType = .min
    var topHeight: CGFloat = 100
    var topViewTopLayout: NSLayoutConstraint!
    var centerTopHeight: CGFloat = GACalenderWeekHeaderView.height + GACalenderControlHeaderView.height
        
    lazy var calenderView: GASelectedDateCalenderView = {
        let v = GASelectedDateCalenderView(frame: CGRect(x: 0, y: 50, width: self.view.width, height: 500))
        v.delegate = self
        return v
    }()
    
    lazy var weekHeaderView: GACalenderWeekHeaderView = {
        let v = "GACalenderWeekHeaderView".xibLoadView() as! GACalenderWeekHeaderView
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy var controlHeaderView: GACalenderControlHeaderView = {
        let v = "GACalenderControlHeaderView".xibLoadView() as! GACalenderControlHeaderView
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var topView: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.width, height: topHeight)
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
        self.view.addSubview(topView)
        self.view.addConstraint(NSLayoutConstraint(item: self.topView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.topView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        self.topView.addConstraint(NSLayoutConstraint(item: self.topView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: GACalenderWeekHeaderView.height + GACalenderControlHeaderView.height))
        
        topViewTopLayout = NSLayoutConstraint(item: self.topView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: kNavigationViewMaxY)
        self.view.addConstraint(topViewTopLayout)
        topView.text = "topView"
        
        topView.addSubview(controlHeaderView)
        topView.ga_addLayout(top: 0, left: 0, width: topView.width, height: GACalenderControlHeaderView.height, item: controlHeaderView, toItem: topView)
        
        topView.addSubview(weekHeaderView)
        topView.ga_addLayout(top: GACalenderControlHeaderView.height, left: 0, width: topView.width, height: GACalenderWeekHeaderView.height, item: weekHeaderView, toItem: topView)
    }
    
    override func base_initTableView() {
        self.view.addSubview(tableView)
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        if isShowTopSave {
            if #available(iOS 11.0, *) {
                tableViewTopLayout = NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .top, multiplier: 1, constant: kNavigationViewMaxY + 20)
            } else {
                tableViewTopLayout = NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .top, multiplier: 1, constant: kNavigationViewMaxY)
            }
        } else {
            tableViewTopLayout = NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: self.topView, attribute: .top, multiplier: 1, constant: kNavigationViewMaxY)
        }

        self.view.addConstraint(tableViewTopLayout)
        tableViewHeightLayout = NSLayoutConstraint(item: self.tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: self.view.frame.size.height - kNavigationViewMaxY - (isShowTabbarView ? kTabBarHeight : 0) - topHeight)
        self.tableView.addConstraint(tableViewHeightLayout)
        
        tableView.yy_register(nibName: GACalenderListCell.identifier)
        tableView.yy_register(nibName: GACalenderContentCell.identifier)
        
        tableView.tableHeaderView = calenderView
        tableView.sectionHeaderHeight = 500
        tableView.tag = 1001
    }
    
}



extension GACalenderController: GACalenderControlHeaderViewDelegate {
    func calenderControlHeaderView_left() {
        
    }
    
    func calenderControlHeaderView_right() {
        
    }
    
    func calenderControlHeaderView_title() {
        
    }
}

extension GACalenderController: GASelectedDateCalenderViewDelegate {
    func selectedDateCalenderView_updateViewsFrame(h: CGFloat) {
        tableView.sectionHeaderHeight = h
        tableView.reloadData()
    }
}

extension GACalenderController {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = GADemoView(frame: CGRect(x: 0, y: 0, width: 400, height: 100))
        v.text = "viewForHeaderInSection"
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
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
            cell.vc = self
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

extension GACalenderController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if (y >= (scrollView.contentSize.height - scrollView.height - 0.5)) {
            self.offsetType = .max
        } else if (y <= 0) {
            self.offsetType = .min
        } else {
//            if y >= 240 {
//                self.offsetType = .max
//                scrollView.contentOffset = CGPoint(x: 0, y: 240)
//                return
//            }
//            if y >= calenderView.height - GACalenderMonthCell.height {
//                self.offsetType = .max
//                scrollView.contentOffset = CGPoint(x: 0, y: calenderView.height - GACalenderMonthCell.height)
//                return
//            }
            self.offsetType = .center
        }
    }
}

class GATableView: UITableView, UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
}
