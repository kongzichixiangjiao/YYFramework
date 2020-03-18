//
//  GA_VantUIViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/5.
//  Copyright © 2019 houjianan. All rights reserved.
//  VantUI入口 TableView手风琴样式

import UIKit
import HandyJSON

class GA_VantUIViewController: YYBaseTableViewController {

    var list: [GAVantUIModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
        
        _initData()
        base_showNavigationView(title: "VantUI", isShow: true)
        base_initTableView()
    }
    
    override func base_initTableView() {
        tableViewStyle = .grouped
        isShowTopSave = false
        super.base_initTableView()
        tableView.yy_register(nibName: GA_VantUICell.identifier)
        tableView.sectionFooterHeight = 20
    }
    
    private func _initData() {
        let path = "vantUI.plist".yy_path()
        let arr = NSArray.init(contentsOf: URL(fileURLWithPath: path))
        self.list = [GAVantUIModel].deserialize(from: arr) as! [GAVantUIModel]
    }
}

extension GA_VantUIViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if list[section].isShow {
            return list[section].rows.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GA_VantUICell.self)
        cell.nameLabel.text = list[indexPath.section].rows[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = GA_VantUIHeaderView.ga_xibView()
        v.delegate = self
        v.section = section
        v.nameLabel.text = list[section].sectionTitle
        v.backgroundColor = UIColor.randomColor()
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        
    }
}

extension GA_VantUIViewController: GA_VantUIHeaderViewDelegate {
    func ga_VantUIHeaderViewClicked(section: Int) {
        for l in list {
            l.isShow = false
        }
        list[section].isShow = true
        tableView.reloadData()
    }
}
