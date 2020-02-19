//
//  GAOfflineTrainingViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/9/23.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class GAOfflineTrainingViewController: GANormalizeBaseTableViewController {

    let data = Observable<[String]>.just(["first element", "second element", "third element"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.yy_register(nibName: GATestViewCell.identifier)

        data.bind(to: tableView.rx.items(cellIdentifier: GATestViewCell.identifier)) {
            index, model, cell in
            (cell as! GATestViewCell).l.text = model 
        }.dispose()
    }

}
