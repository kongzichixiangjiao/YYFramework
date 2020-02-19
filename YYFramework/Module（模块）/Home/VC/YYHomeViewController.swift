//
//  YYHomeViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/30.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

enum HomeCellType: Int {
    case sort = 1, ad = 2, scrollImage = 3, pxResearch = 4, vip = 5
}

class YYHomeViewController: YYBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView()
        base_initTableView()

    }
    
    override func base_initTableView() {
        super.base_initTableView()
        isShowTabbarView = true
        
        tableView.yy_register(nibNames: [GraphicsEndImageCell.identifier,
                                         YYSortTableViewCell.identifier,
                                         YYVIPTableViewCell.identifier])
        initHeaderView()
        
    }
    
    func initHeaderView() {
        var models: [YYTableADViewModel] = []
        for i in 0...4 {
            let model = YYTableADViewModel()
            model.text = "消息第" + "\(i)" + "条"
            models.append(model)
        }
        let v = YYTableADView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: kYYScrollADViewHeight), models: models)
        tableView.tableHeaderView = v
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YYHomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GraphicsEndImageCell.identifier) as! GraphicsEndImageCell
            return cell
        } else if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYSortTableViewCell.identifier) as! YYSortTableViewCell
            cell.mDelegate = self
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYVIPTableViewCell.identifier) as! YYVIPTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: GraphicsEndImageCell.identifier) as! GraphicsEndImageCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return (self.view.bounds.width / 4) * 2
        }
        if indexPath.row == 2 {
            return 60
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = GAPageControlViewController(nibName: "GAPageControlViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = GAEstimatedCollectionViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        self.navigationController?.pushViewController(ZHCalendarViewController(), animated: true)
//        self.navigationController?.pushViewController(ZHNewCalendarScrollViewController(), animated: true)
//        self.navigationController?.pushViewController(ZHCalendarCollectionViewController(), animated: true)
//        self.navigationController?.pushViewController(ZHCalendarScrollViewController(), animated: true)
//        self.navigationController?.pushViewController(ZHHomeViewController(), animated: true)
    }
}

extension YYHomeViewController: ZHSortCollectionCellDelegate {
    func sortTableViewCellDidSelected(row: Int) {
        print(row)
    }
}
