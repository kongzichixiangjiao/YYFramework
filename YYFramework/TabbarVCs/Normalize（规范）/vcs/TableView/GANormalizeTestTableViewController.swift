//
//  GANormalizeTestTableViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/14.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormalizeTestTableViewController: GANormalizeBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func initViews() {
        tableView.yy_register(nibNames: [GANormalizeTestEstimatedTableViewCell.identifier, GANormalizeTestTableViewCell.identifier])
        
        base_isNavigationViewAnimation = true
        
        tableView.estimatedRowHeight = 44
        
        super.initViews()
    }
}

extension GANormalizeTestTableViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        base_navigationViewAnimation(y: scrollView.contentOffset.y)
    }
}

extension GANormalizeTestTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GANormalizeTestTableViewCell.identifier, for: indexPath) as! GANormalizeTestTableViewCell
            cell.l.text = "GANormalizeTestTableViewCell"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: GANormalizeTestEstimatedTableViewCell.identifier, for: indexPath) as! GANormalizeTestEstimatedTableViewCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
