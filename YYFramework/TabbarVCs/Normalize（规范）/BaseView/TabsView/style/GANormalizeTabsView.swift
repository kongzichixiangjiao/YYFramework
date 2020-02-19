//
//  GANormalizeTabsView.swift
//  YYFramework
//
//  Created by houjianan on 2019/4/2.
//  Copyright © 2019 houjianan. All rights reserved.
//  头部其中一个样式

/*
 let row = 4
 let titles = ["1", "我是二", "我是三三", "我是测试我是", "我是测试我是", "我是三三", "我是测试我是", "我是测试我是", "我是三三", "我是测试我是", "我是测试我是"]
 let column = (titles.count / row) == 0 ? 1 : ((titles.count % row != 0) ? (titles.count / row + 1) : titles.count / row)
 let isScrollEnabled: Bool = false
 let h = isScrollEnabled ? 40 : column * 40
 let v = GANormalizeTabsView(frame: CGRect(x: 0, y: 50, width: view.width, height: CGFloat(h)), row: row, titles: titles, isScrollEnabled: true) { (title, index) in
 print(title, index)
 }
 view.addSubview(v)
 */
import UIKit

class GANormalizeTabsView: GANormalizeBaseTabsView {
    
    private var _row: Int = 3 // 横行个数
    private var _column: Int = 0 // 竖行列数
    private var _itemHeight: CGFloat = 40.0
    private var _titles: [String] = []
    private var _currentIndex: Int = 0
    private var _isScrollEnabled: Bool = false  // 能滑动 column = 1 row = 4
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        #if DEBUG
        print(CGFloat(min(self._row, self._titles.count)))
        #endif
        layout.itemSize = CGSize(width: self.frame.size.width / CGFloat(min(self._row, self._titles.count)), height: self._itemHeight)
        if self._isScrollEnabled {
            layout.scrollDirection = .horizontal
        }
        let v = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        v.backgroundColor = UIColor.white
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        v.isScrollEnabled = self._isScrollEnabled
        v.delegate = self
        v.dataSource = self
        if #available(iOS 11.0, *) {
            v.contentInsetAdjustmentBehavior = .never
        }
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    convenience init(frame: CGRect, row: Int = 3, titles: [String], isScrollEnabled: Bool = false, clickedItemHandler: @escaping ClickedItemHandler) {
        self.init(frame: frame)
        
        self._clickedItemHandler = clickedItemHandler
        self._isScrollEnabled = isScrollEnabled
        self._titles = titles
        
        if isScrollEnabled {
            self._column = 1
            self._row = 4
        } else {
            let count = self._titles.count
            self._column = (count / self._row) == 0 ? 1 : ((count % self._row != 0) ? (self._titles.count / self._row + 1) : count / self._row)
            self._row = row
        }
        _initViews()
    }
    
    private func _initViews() {
        collectionView.register(UINib(nibName: "GANormalizeTabsCell", bundle: nil), forCellWithReuseIdentifier: "GANormalizeTabsCell")
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _column(row: Int) -> Bool {
        if (row + 1 > self._row * (self._column - 1)) {
            return true
        } else {
            return false
        }
    }
    
    override func moveTo(index: Int) {
        _currentIndex = index
        collectionView.reloadData()
    }
    
}
extension GANormalizeTabsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GANormalizeTabsCell", for: indexPath) as! GANormalizeTabsCell
        let title = _titles[indexPath.row]
        cell.mTitleLabel.font = UIFont.systemFont(ofSize: title.count > 5 ? 12 : 14)
        cell.mTitleLabel.text = _titles[indexPath.row]
        cell.lineView.isHidden = !(indexPath.row == _currentIndex)
        if self._column == 1 {
            cell.bottomLineView.isHidden = true
        } else {
            cell.bottomLineView.isHidden = _column(row: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _currentIndex = indexPath.row
        collectionView.reloadData()
        
        let title = self._titles[indexPath.row]
        _clickedItemHandler?(title, _currentIndex)
        
        delegate?.ga_normalizeBaseTabsViewClickedItem(title: title, index: _currentIndex)
    }
    
    
}
