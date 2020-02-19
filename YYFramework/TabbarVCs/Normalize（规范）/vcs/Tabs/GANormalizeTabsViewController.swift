//
//  GANormalizeTabsViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/4/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GANormalizeTabsViewController: GANormalizeTabsBaseViewController {

    lazy var tabsView: GANormalizeTabsView = {
        let row = 4
        //        let titles = ["1", "我是二", "我是三三", "我是测试我是", "我是测试我是", "我是三三", "我是测试我是", "我是测试我是", "我是三三", "我是测试我是", "我是测试我是"]
        let titles = ["1", "我是二", "我是三三", "我是测试我是"]
        let column = (titles.count / row) == 0 ? 1 : ((titles.count % row != 0) ? (titles.count / row + 1) : titles.count / row)
        let isScrollEnabled: Bool = false
//        let h = isScrollEnabled ? 40 : column * 40
        let h = 40
        let v = GANormalizeTabsView(frame: CGRect(x: 0, y: 50, width: view.width, height: CGFloat(h)), row: row, titles: titles, isScrollEnabled: true) { (title, index) in
            print(title, index)
            self.tabsMainView.moveToVC(index: index)
        }
        return v
    }()
    

}

