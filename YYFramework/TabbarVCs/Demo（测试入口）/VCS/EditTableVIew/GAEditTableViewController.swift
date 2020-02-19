
//
//  GAEditTableViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/9/4.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAEditTableViewController: YYBaseTableViewController {

   override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView(title: "编辑cell")
        base_initTableView()
    }

    override func base_initTableView() {
        super.base_initTableView()
        tableView.ga_register(cellClass: GATestViewCell.self)
        b_editingStyle = .delete
    }

}

extension GAEditTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GATestViewCell.self)
        cell.textLabel?.text = "左滑删除"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
    }
}
