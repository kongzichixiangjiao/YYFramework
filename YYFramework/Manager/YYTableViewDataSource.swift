//
//  TableViewDataSource.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/15.
//  Copyright © 2018年 houjianan. All rights reserved.
//  解耦VC

import UIKit

// TableViewCell的数据源基类
public class YYTableViewCellBaseModel {
    var identifier: String = ""
}

// MARK: 多个cell
class YYTableViewDataSource: NSObject {
    
    typealias TableViewCellConfigureBlock = (_ cell: UITableViewCell, _ item: Any) -> ()
    
    var items: [Any]!
    var configureCellBlock: TableViewCellConfigureBlock?

    convenience init(items: [Any], configureCellBlock: @escaping TableViewCellConfigureBlock) {
        self.init()
        
        self.items = items
        self.configureCellBlock = configureCellBlock
    }
    
    func itemAt(indexPath: IndexPath) -> Any {
        return self.items[indexPath.row]
    }
    
}

extension YYTableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemAt(indexPath: indexPath) as! YYTableViewCellBaseModel
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
        configureCellBlock?(cell, item)
        return cell
    }
}

/*
例：
class ViewController: YYBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: YYTableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configureCell: YYTableViewDataSource.TableViewCellConfigureBlock = {
            [weak self] cell, model in
            if self != nil {
                if (model as! YYTableViewCellBaseModel).identifier == "TableViewCell" {
                    (cell as! TableViewCell).label.text = (model as! YYTableViewCellModel).text
                } else {
                    (cell as! TableViewCell1).textLabel?.text = (model as! YYTableViewCellModel1).text
                }
            }
        }
        
        var arr = [YYTableViewCellBaseModel]()
        for i in 0..<5 {
            if i == 2 {
                let model = YYTableViewCellModel()
                model.identifier = "TableViewCell"
                arr.append(model)
            } else {
                let model = YYTableViewCellModel1()
                model.identifier = "TableViewCell1"
                arr.append(model)
            }
        }
        
        dataSource = YYTableViewDataSource(items: arr, configureCellBlock: configureCell)
        
        self.tableView.dataSource = dataSource
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        tableView.register(UINib(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "TableViewCell1")
        
        self.rootVC?.root_registerNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

class YYTableViewCellModel: YYTableViewCellBaseModel {
    var text: String = "22"
}

class YYTableViewCellModel1: YYTableViewCellBaseModel {
    var text: String = "11"
}
*/



// MARK: 单个cell
class YYTableViewOnceDataSource: NSObject {
    
    typealias TableViewCellConfigureBlock = (_ cell: UITableViewCell, _ item: Any) -> ()
    
    var items: [Any]!
    var cellIdentifier: String!
    var configureCellBlock: TableViewCellConfigureBlock?
    
    convenience init(items: [Any], cellIdentifier: String, configureCellBlock: @escaping TableViewCellConfigureBlock) {
        self.init()
        
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureCellBlock
    }
 
    func itemAt(indexPath: IndexPath) -> Any {
        return self.items[indexPath.row]
    }
    
}

extension YYTableViewOnceDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = itemAt(indexPath: indexPath)
        configureCellBlock?(cell, item)
        return cell
    }
}

/*
例：
class ViewController: YYBaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource: YYTableViewOnceDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configureCell: YYTableViewOnceDataSource.TableViewCellConfigureBlock = {
            [weak self] cell, model in
            if self != nil {
                (cell as! TableViewCell).label.text = model as! String
            }
        }
        
        dataSource = YYTableViewOnceDataSource(items: ["1", "2", "3"], cellIdentifier: "TableViewCell", configureCellBlock: configureCell)
        
        self.tableView.dataSource = dataSource
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        self.rootVC?.root_registerNotification()
    }
}
*/

