//
//  GACalenderContentCell.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/16.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalenderContentCell: UITableViewCell {
    
    @IBOutlet weak var tableView: GATableView!
    var offsetType: ScrollOffsetType = .min
    
    weak var vc: GACalenderController?
    weak var vc4: GACalenderController4?
    weak var vc5: GACalenderController5?
    
    var currentScrollDirection: GAScrollDirection? = .normal
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.yy_register(nibName: GACalenderListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension GACalenderContentCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("GACalenderContentCell - scrollViewDidScroll")
        var type: ScrollOffsetType!
        if let vc = vc4 {
            type = vc.offsetType
        }
        if let vc = vc {
            type = vc.offsetType
        }
        if let vc = vc5 {
            type = vc.offsetType
        }
        let y = scrollView.contentOffset.y
        
        if y <= 0 {
            offsetType = .min
        } else {
            offsetType = .center
        }
        
        if type == .min {
            scrollView.contentOffset = CGPoint.zero
        }
        
        if type == .center {
//            if currentScrollDirection == .up {
                scrollView.contentOffset = CGPoint.zero
//            }
        }
        
        if type == .max {
            
        }
        
        if type == .other {

        }
        
    }
}

extension GACalenderContentCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GACalenderListCell.self)
        cell.l.text = "content" + String(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
