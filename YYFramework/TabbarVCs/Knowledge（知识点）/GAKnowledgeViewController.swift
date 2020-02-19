//
//  GAKnowledgeViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/12.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

class GAKnowledgeViewController: YYBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        base_showNavigationView(title: "Demo", isShow: true)
        base_initTableView()
    }
    
    override func base_initTableView() {
        super.base_initTableView()
        tableView.yy_register(nibName: GATestViewCell.identifier)
    }
    
    func initData() {
        dataSource = ["0、KVC"
        ]
    }
}

extension GAKnowledgeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GATestViewCell.identifier, for: indexPath) as! GATestViewCell
        cell.l.text = dataSource[indexPath.row] as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcs = [
            dataSource[0] as! String : PresentsViewController(nibName: "PresentsViewController", bundle: nil)
        ]
        
        let name = dataSource[indexPath.row] as! String
        let vc = vcs[name]
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
