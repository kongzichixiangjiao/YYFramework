//
//  YYInterlockView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit


class YYInterlockView: UIView {
    
    private var kSectionHeight: CGFloat = 60.0 // 标题视图高度
    private var kHeaderViewHeight: CGFloat = 300 // 标题视图+topView的高
    
    private var vcs: [UIViewController] = [] // 横向滑动的容器
    private var titles: [String] = [] // 标题
    private var scrollViews: [UIScrollView] = [] // 横向滑动容器里面的scrollView
    
    var currentIndex: Int = 0 // 横向滑动停留在当前哪个容易
    
    private var topView: UIView? // 顶部
    
    // 一个cell 一个headerView
    lazy var tableView: YYInterlockTableView = {
        let t = YYInterlockTableView(frame: self.bounds)
        t.delegate = self
        t.dataSource = self
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        t.tableFooterView = UIView()
        t.alwaysBounceVertical = false 
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, vcs: [UIViewController], pageTitles: [String] = [], topView: UIView? = nil) {
        self.init(frame: frame)
        
        if let v = topView {
            self.kHeaderViewHeight = v.frame.size.height + kSectionHeight
        }
        if pageTitles.count == 0 {
            self.kSectionHeight = 0
        }
        self.vcs = vcs
        self.titles = pageTitles
        self.topView = topView
        
        for vc in vcs {
            let s = vc.yy_scrollView
            scrollViews.append(s!)
        }
        
        initViews()
    }
    
    private func initViews() {
        initTableView()
        initTopView()
        initVCS()
    }
    
    private func initVCS() {
        for s in scrollViews {
            s.delegate = self
            if titles.count != 0 || topView != nil {
                s.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.width, height: self.bounds.height - kSectionHeight))
            } else {
                s.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: tableView.width, height: self.bounds.height))
            }
        }
    }
    
    private func initTopView() {
        if titles.count != 0 || topView != nil {
            tableView.tableHeaderView = headerView
        } else {
            for s in scrollViews {
                s.isScrollEnabled = true
            }
        }
    }
    
    private func initTableView() {
        self.addSubview(tableView)
        tableView.frame = self.bounds
        tableView.yy_register(nibName: YYInterlockCell.identifier)
    }
    
    // 标题视图和topview在headerview上
    lazy var headerView: YYInterlockHeaderView = {
        let v = YYInterlockHeaderView(frame: CGRect(x: 0, y: 0, width: self.width, height: kHeaderViewHeight - (titles.count != 0 ? 0 : kSectionHeight)))
        v.backgroundColor = UIColor.randomColor()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.topView = self.topView
        if titles.count != 0 {
            v.titles = self.titles
        }
        return v
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YYInterlockView: UIGestureRecognizerDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 没有标题和top视图
        if titles.count == 0 || topView == nil {
            return
        }
        let y = scrollView.contentOffset.y
        let vc = self.vcs[currentIndex]
        guard let t = vc.yy_scrollView else {
            return
        }
        if (y >= kHeaderViewHeight - kSectionHeight ) {
            tableView.contentOffset = CGPoint(x: 0, y: kHeaderViewHeight - kSectionHeight)
            
            if t.contentOffset.y >= 0 {
                t.isScrollEnabled = true
            } else {
                t.isScrollEnabled = false
            }
        } else {
            if t.contentOffset.y > 0 && t.contentOffset.y != 0 {
                tableView.contentOffset = CGPoint(x: 0, y: kHeaderViewHeight - kSectionHeight)
            } else {
                t.isScrollEnabled = false
            }
        }
    }
}

extension YYInterlockView: UITableViewDelegate, UITableViewDataSource {
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYInterlockCell.identifier) as! YYInterlockCell
        cell.viewSize = CGSize(width: tableView.width, height: self.bounds.height)
        cell.vcs = self.vcs
        cell.delegate = self
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.bounds.height
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
}

extension YYInterlockView: YYInterlockCellDelegate {
    func interlockCellScrollDidIndex(index: Int) {
        currentIndex = index
        
    }
}


