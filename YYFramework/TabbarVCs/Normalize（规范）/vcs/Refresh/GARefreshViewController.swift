//
//  GARefreshViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/7/19.
//  Copyright © 2019 houjianan. All rights reserved.
//  刷新

import UIKit
import ESPullToRefresh

class GARefreshViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        self.tableView.es.addPullToRefresh {
            [unowned self] in
            
            self.dataSource = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
            self.tableView.reloadData()
            
            /// Stop refresh when your job finished, it will reset refresh footer if completion is true
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
            /// Set ignore footer or not
            self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            
            self.tableView.es.resetNoMoreData()
        }
        
        self.tableView.es.addInfiniteScrolling {
            [unowned self] in
            
            self.dataSource += [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
            self.tableView.reloadData()
            
            /// If common end
            self.tableView.es.stopLoadingMore()
            /// If no more data
            if self.dataSource.count == 40 {
                self.tableView.es.noticeNoMoreData()
            }
        }
        
        base_showNavigationView(title: "list", isShow: true)
        base_initTableView()
    }
    
    override func base_initTableView() {
        super.base_initTableView()
        tableView.yy_register(nibName: GANormalizeTestCell.identifier)
    }
}

extension GARefreshViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GANormalizeTestCell.self, for: indexPath)
        cell.l.text = "\(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
}

