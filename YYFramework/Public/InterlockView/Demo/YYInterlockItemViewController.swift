//
//  YYInterlockItemViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class YYInterlockItemViewController: UIViewController, UIScrollViewDelegate {
    
    lazy var tableView: UITableView = {
        let t = UITableView(frame: CGRect.zero)
        t.delegate = self
        t.dataSource = self
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        t.tableFooterView = UIView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isScrollEnabled = false
        t.tag = 2001
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.randomColor()
        self.view.addSubview(tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.yy_register(nibName: YYInterlockTestCell.identifier)
        self.tableView.backgroundColor = UIColor.randomColor(1)
        self.yy_scrollView = self.tableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.tableView.reloadData()
    }
    
}

extension YYInterlockItemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYInterlockTestCell.identifier, for: indexPath) as! YYInterlockTestCell
        cell.mTitleLabel.text = indexPath.row.toString()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 22
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
}

