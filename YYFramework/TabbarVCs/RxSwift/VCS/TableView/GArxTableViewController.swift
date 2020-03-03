//
//  GArxTableViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/29.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RxModel {
    var name: String = ""
}

class GArxTableViewController: GARxSwiftBaseViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, RxModel>>(configureCell: {
        s, t, indexPath, m in
        let cell = t.dequeueReusableCell(withIdentifier: GArxTableViewCell.identifier, for: indexPath) as! GArxTableViewCell
        cell.l.text = m.name
        return cell
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let m1 = RxModel()
        m1.name = "name1"
        
        let m2 = RxModel()
        m2.name = "name2"
        let models = [m1, m2]
        let s1 = SectionModel(model: "section1", items: models)
        let s2 = SectionModel(model: "section2", items: models)
        let items = Observable.just([s1, s2])
        
        dataSource.titleForHeaderInSection = {
            data, section in
            return data[section].model
        }
        
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(RxModel.self)
            .subscribe(onNext: { (model) in
            print(model.name)
            }).disposed(by: disposeBag)
     
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    
}

extension GArxTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
}

class GArxTableViewCell: UITableViewCell {
    @IBOutlet weak var l: UILabel!
    @IBOutlet weak var b: UIButton!
}
