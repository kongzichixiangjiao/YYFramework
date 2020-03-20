//
//  GAPickerView.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/12.
//  Copyright © 2020 houjianan. All rights reserved.
//  自定义选择器

/*
class GASelectedStarEndDateViewController: GANavViewController {
    
    private let kStackViewHeight: CGFloat = 200
    
    lazy var pickView: GAPickerView = {
        let v = GAPickerView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: 40 * 5), dataSource: dataSource, configModel: nil)
        return v
    }()
    
    var dataSource = [["2015", "2016", "2017", "2018", "2019", "2020"], ["年"], ["1", "2", "3"], ["月"], ["1", "2", "3", "4"], ["日"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        b_showNavigationView(title: "pickerView选择器")
        
        self.view.addSubview(pickView)
    }
}
*/

import UIKit

class GAPickerViewModel {
    var kItemHeight: CGFloat = 40
}

class GAPickerView: UIView {
    
    var dataSource: [[String]] = []
    
    var resultData = [String]()
    var configModel: GAPickerViewModel = GAPickerViewModel()
    
    private var redundantCount: Int = -1
    private var tableViews = [UITableView]()
    
    lazy var mainView: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 200, width: self.frame.size.width, height: self.frame.size.height)
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.distribution = .fillEqually
        v.axis = .horizontal
        v.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        return v
    }()
    
    convenience init(frame: CGRect, dataSource: [[String]], configModel: GAPickerViewModel?) {
        self.init(frame: frame)
        
        if let item = configModel {
            self.configModel = item
        }
        
        self.dataSource = dataSource
        
        _initViews()
        _initData()
    }
    
    private func _initViews() {
        self.addSubview(stackView)
        
        for i in 0..<dataSource.count {
            let t = UITableView()
            t.tag = i
            t.showsHorizontalScrollIndicator = false
            t.showsVerticalScrollIndicator = false
            t.delegate = self
            t.dataSource = self
            t.register(UINib(nibName: "GAPickerDataCell", bundle: nil), forCellReuseIdentifier: "GAPickerDataCell")
            stackView.addArrangedSubview(t)
            
            let data = dataSource[i]
            t.isScrollEnabled = data.count > 1
            
            tableViews.append(t)
        }
    }
    
    private func _initData() {
        for i in 0..<dataSource.count {
            var data = dataSource[i]
            let rows = Int(self.frame.size.height / configModel.kItemHeight)
            redundantCount = rows / 2
            
            resultData.append(data.first ?? "")
            
            for _ in 0..<redundantCount {
                data.insert("", at: 0)
                data.append("")
            }
            dataSource[i] = data
            
            tableViews[i].reloadData()
        }
    }
    
    deinit {
        print("GASelectedStarEndDateViewController - deinit")
    }
}

extension GAPickerView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !scrollView.isScrollEnabled {
            return
        }
        let _ = tableViews.map {
            if $0.tag != scrollView.tag {
                $0.isScrollEnabled = false
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _setupPosition(scrollView: scrollView)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        getResultData(scrollView)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        getResultData(scrollView)
        _setupPosition(scrollView: scrollView)
    }
    
    private func getResultData(_ scrollView: UIScrollView) {
        let t = scrollView as! UITableView
        let tag = t.tag
        let y = t.contentOffset.y
        let count = Int(y / configModel.kItemHeight)
        resultData[tag] = dataSource[tag][count + redundantCount]
        
        print(resultData)
        
        let _ = tableViews.map {
            if $0.tag != scrollView.tag && dataSource[$0.tag].count != (redundantCount * 2 + 1) {
                $0.isScrollEnabled = true
            }
        }
    }
    
    private func _setupPosition(scrollView: UIScrollView) {
        let t = scrollView as! UITableView
        let y = t.contentOffset.y
        let item: CGFloat = y.truncatingRemainder(dividingBy: configModel.kItemHeight)
        let count = Int(y / configModel.kItemHeight)
        
        if count >= 0 {
            if item < configModel.kItemHeight / 2 {
                t.scrollToRow(at: IndexPath(item: count + redundantCount, section: 0), at: .middle, animated: true)
            } else {
                t.scrollToRow(at: IndexPath(item: count + redundantCount + 1, section: 0), at: .middle, animated: true)
            }
        }
    }
    
        
}

extension GAPickerView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tag = tableView.tag
        let model = dataSource[tag]
        return model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return configModel.kItemHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GAPickerDataCell", for: indexPath) as! GAPickerDataCell
        let tag = tableView.tag
        let model = dataSource[tag]
        cell.l.text = model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
