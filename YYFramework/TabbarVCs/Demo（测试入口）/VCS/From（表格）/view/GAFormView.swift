//
//  GAFormView.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/20.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAFormView: UIView {
    
    var configModel: GAFormConfigModel = GAFormConfigModel()
    
    var lData: [GAFormModel] = [] // 左侧数据
    var rData: [GAFormModel] = [] // 右侧数据
    var topTitlesData: [String] = []
    
    lazy var lTableView: UITableView = {
        let t = UITableView(frame: CGRect.zero, style: .plain)
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        t.bounces = false
        t.tableFooterView = UIView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    lazy var rTableView: UITableView = {
        let t = UITableView(frame: CGRect.zero, style: .plain)
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        t.bounces = false
        t.tableFooterView = UIView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: self.configModel.lItemWidth, y: 0, width: self.frame.size.width - self.configModel.lItemWidth, height: self.frame.size.height))
        v.backgroundColor = UIColor.yellow
        v.bounces = false
        return v
    }()
    
    lazy var lAngleView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: self.configModel.lItemWidth, height: self.configModel.topViewHeight))
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    lazy var topTitleView: GAFormTopTitleView = {
        let v = GAFormTopTitleView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.configModel.topViewHeight))
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initData()
        
        _initViews()
    }
    
    private func _initViews() {
        self.addSubview(lAngleView)
        
        let contentSizeW: CGFloat = CGFloat(rData[0].rows[0].count) * self.configModel.rItemWidth
        scrollView.contentSize = CGSize(width: contentSizeW, height: scrollView.size.height)
        self.addSubview(scrollView)
        
        topTitleView.frame = CGRect(x: 0, y: 0, width: contentSizeW, height: self.configModel.topViewHeight)
        scrollView.addSubview(topTitleView)
        topTitleView.configModel = self.configModel
        topTitleView.initItemsView(items: topTitlesData)
        
        rTableView.yy_register(nibName: GAFormItemCell.identifier)
        rTableView.frame = CGRect(x: 0, y: topTitleView.frame.size.height, width: scrollView.contentSize.width, height: scrollView.size.height - topTitleView.frame.size.height)
        self.scrollView.addSubview(rTableView)
        rTableView.delegate = self
        rTableView.dataSource = self
        
        lTableView.yy_register(nibName: GAFormLeftItemCell.identifier)
        lTableView.frame = CGRect(x: 0, y: topTitleView.frame.size.height, width: self.configModel.lItemWidth, height: scrollView.size.height - topTitleView.frame.size.height)
        self.addSubview(lTableView)
        lTableView.backgroundColor = UIColor.clear
        lTableView.delegate = self
        lTableView.dataSource = self
    }
    
    private func _initData() {
        for i in 0..<8 {
            let model = GAFormModel()
            model.sectionTitle = "L-" + "\(i)"
            
            for j in 0..<10 {
                let item = GAFormRowModel()
                item.title = "L" + "\(i)" + "\(j)"
                model.columns.append(item)
            }
            lData.append(model)
        }
        // 共有section多少个
        for i in 0..<8 {
            let model = GAFormModel()
            model.sectionTitle = "R-" + "\(i)"
            // section内有多少个item
            for j in 0..<10 {
                var rowItems = [GAFormRowModel]()
                var comlumnItems = [GAFormRowModel]()
                
                // 每个item有多少个字段
                for k in 0..<20 {
                    let rowItem = GAFormRowModel()
                    rowItem.title = "\(i)" + "-" + "\(j)" + "-" + "\(k)"
                    rowItems.append(rowItem)
                    
                    let comlumnItem = GAFormRowModel()
                    comlumnItem.title = "R" + "\(i)" + "\(j)"
                    comlumnItems.append(comlumnItem)
                }
                model.rows.append(rowItems)
                model.columns = comlumnItems
            }
            rData.append(model)
        }
        
        for i in 0..<20 {
            let s = "Title" + "\(i)"
            topTitlesData.append(s)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GAFormView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        if scrollView == rTableView {
            lTableView.contentOffset.y = y
        }
        
        if scrollView == lTableView {
            rTableView.contentOffset.y = y
        }
    }
}

extension GAFormView: GAFormHeaderViewDelegate, GAFormLeftHeaderViewDelegate {
    func ga_formHeaderViewClicked(section: Int) {
        clickedHeaderViewReload(section: section)
    }
    
    func ga_formLeftHeaderViewDelegateClicked(section: Int) {
        clickedHeaderViewReload(section: section)
    }
    
    func clickedHeaderViewReload(section: Int) {
        for l in lData {
            l.isShow = false
        }
        lData[section].isShow = true
        lTableView.reloadData()
        
        for l in rData {
            l.isShow = false
        }
        rData[section].isShow = true
        rTableView.reloadData()
    }
}

extension GAFormView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == rTableView {
            let v = GAFormHeaderView.ga_xibView()
            v.configModel = configModel
            v.delegate = self
            v.section = section
            v.items = rData[section].columns
            v.backgroundColor = UIColor.lightGray
            return v
        } else {
            let v = GAFormLeftHeaderView.ga_xibView()
            v.delegate = self
            v.section = section
            v.nameLabel.text = lData[section].sectionTitle
            v.backgroundColor = UIColor.lightText
            return v
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.configModel.itemHeaderHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == rTableView {
            return rData.count
        }
        return lData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rTableView {
            if rData[section].isShow {
                return rData[section].rows.count
            }
            return 0
        }
        if lData[section].isShow {
            return lData[section].columns.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == rTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: GAFormItemCell.identifier, for: indexPath) as! GAFormItemCell
            cell.configModel = self.configModel
            cell.items = rData[indexPath.section].rows[indexPath.row]
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: GAFormLeftItemCell.identifier, for: indexPath) as! GAFormLeftItemCell
        cell.l.text = lData[indexPath.section].columns[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.configModel.itemHeight
    }
    
}


@IBDesignable
class GAFormOnePixView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mySetOnePixView()
    }
    
    func mySetOnePixView() {
        for layout in self.constraints {
            if (layout.firstItem as! NSObject == self && (layout.firstAttribute == NSLayoutConstraint.Attribute.width || layout.firstAttribute == NSLayoutConstraint.Attribute.height)) {
                if (layout.constant == 1) {
                    layout.constant = 1.0 / UIScreen.main.scale
                }
            }
        }
    }
}
