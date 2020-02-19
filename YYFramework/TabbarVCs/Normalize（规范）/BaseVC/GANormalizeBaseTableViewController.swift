//
//  GANormalizeTableViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/14.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormalizeBaseTableViewController: GANormalizeBaseViewController {
    private var base_preventRepeatClicked: Bool = false
    
    public var dataSource: [Any] = []
    
    public lazy var tableView: UITableView = {
        let t = UITableView(frame: CGRect.zero)
        t.delegate = self
        t.dataSource = self
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        t.tableFooterView = UIView()
        t.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            t.contentInsetAdjustmentBehavior = .never
        }
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func initViews() {
        self.view.addSubview(tableView)
        
        super.initViews()
        
        initTableViews()
    }
    
    public func initTableViews() {
        let y = base_isNavigationViewAnimation ? 0 : (base_isShowNavigationView ? navigationView.frame.size.height : 0)
        let h = self.view.bounds.height - y - (base_isShowTabbarView ? kTabBarHeight : 0)
        tableView.frame = CGRect(x: 0, y: y, width: self.view.bounds.width, height: h)
        
        if base_isNavigationViewAnimation {
            let top = tableView.contentInset.top
            tableView.contentInset = UIEdgeInsets(top: navigationView.frame.maxY + top, left: 0, bottom: 0, right: 0)
            // tableView第一次初始化contentOffset需要主动修改。collectionview没有这种情况
            tableView.contentOffset = CGPoint(x: 0, y: -(navigationView.frame.maxY + top))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc public func base_preventRepeatClicked(b: Bool) {
        base_preventRepeatClicked = b
    }
}

extension GANormalizeBaseTableViewController: UITableViewDelegate, UITableViewDataSource {
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
        if !base_preventRepeatClicked {
            base_preventRepeatClicked = true
            tableView.deselectRow(at: indexPath, animated: true)
            self.perform(#selector(base_preventRepeatClicked(b:)), with: false, afterDelay: 1.0)
        } else {
            return
        }
    }
}

extension GANormalizeBaseTableViewController: GANormalizeBaseNavigationAnimationProtocol {
    func base_navigationViewAnimation(y: CGFloat) {
        let tempY = y + tableView.contentInset.top
        if base_isShowNavigationView && base_isNavigationViewAnimation {
            /*
             *  具体动画按需求实现
             */
            if tempY < 0 {
                navigationView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kStatusBarHeight + kNavigationHeight)
                return
            }
            if tempY > kStatusBarHeight + kNavigationHeight {
                navigationView.frame = CGRect(x: 0, y: -kStatusBarHeight - kNavigationHeight, width: kScreenWidth, height: kStatusBarHeight + kNavigationHeight)
                return
            }
            self.navigationView.frame = CGRect(x: 0, y: -tempY, width: kScreenWidth, height: kStatusBarHeight + kNavigationHeight)
        }
    }
}

