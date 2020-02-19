//
//  GAStackViewViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/7/29.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAStackViewViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        _initViews()
    }

    private func _initViews() {
        
        let arr = ["我是测试九个字八九", "我是测试", "我是六个字六", "我", "特别", "我是很多个字三六九", "八九十啊", "敖丙龙太子", "哪吒"]
        
        var ls = [UILabel]()
        for title in arr {
            let l = UILabel()
            l.text = title
            ls.append(l)
            stackView.insertArrangedSubview(l, at: 0)
        }
        
//        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 400, width: kScreenWidth, height: 40))
//        scrollView.backgroundColor = UIColor.orange
//        view.addSubview(scrollView)
//
//        scrollView.contentSize = CGSize(width: kScreenWidth * 4, height: 40)
//
//        let stackView = UIStackView(arrangedSubviews: ls)
//        stackView.frame = CGRect(x: 0, y: 0, width: kScreenWidth * 4, height: 40)
//        scrollView.addSubview(stackView)
//        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally
//        stackView.spacing = 20
        
    }

}
