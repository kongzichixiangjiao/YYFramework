//
//  GANormalizeTabsStackView.swift
//  YYFramework
//
//  Created by houjianan on 2019/6/10.
//  Copyright © 2019 houjianan. All rights reserved.
//  头部其中一个样式

import UIKit

class GANormalizeTabsStackView: GANormalizeBaseTabsView {

    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        return v
    }()
    
    lazy var stackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.distribution = .fillEqually
        return v
    }()
    
    lazy var _lineView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    lazy var _segmentationView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    lazy var lineStackView: UIStackView = {
        let v = UIStackView()
        v.axis = .horizontal
        v.distribution = .fillEqually
        return v
    }()

    private var _items: [UIView] = []
    private var _lineWidths: [CGFloat]!
    
    convenience init(frame: CGRect, isShowLineView: Bool = true) {
        self.init(frame: frame)
        
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width: self.bounds.width + 1, height: self.bounds.height)
        self.addSubview(scrollView)
        
        scrollView.addSubview(_lineView)
        
        stackView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 2)
        
        scrollView.addSubview(stackView)
    }
    
    public func initItems(items: [UIView], lineView: UIView?) {
        _items = items
        
        _updateItems()
        
        _updateLineView(v: lineView)
    }
    
    public func initDefaultItems(titles: [String], lineView: UIView?) {
        var items = [UIView]()
        
        for i in 0..<titles.count {
            let title = titles[i]
            let l = _initNormalizeTabsLabel(text: title)
            items.append(l)
        }
        
        initItems(items: items, lineView: lineView)
    }
    
    private func _initNormalizeTabsLabel(text: String) -> UILabel {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: 14)
        v.textColor = UIColor.gray
        v.textAlignment = .center
        v.text = text
        return v
    }
    
    private func _updateItems() {
        for i in 0..<_items.count {
            let item = _items[i]
            item.tag = i
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapItemAction))
            item.isUserInteractionEnabled = true
            item.addGestureRecognizer(tap)
            
            stackView.addArrangedSubview(item)
        }
    }
    
    private func _updateLineView(v: UIView?) {
        if let l = v {
            _lineView = l
        } else {
            _lineView.frame = CGRect(x: 0, y: self.bounds.height - 2, width: self.bounds.width / CGFloat(_items.count), height: 2)
        }
    }
    
    @objc func tapItemAction(sender: UITapGestureRecognizer) {
        if let v = sender.view {
            let tag = v.tag
            _moveAnimation(index: tag)
            
            delegate?.ga_normalizeBaseTabsViewClickedItem(title: "", index: tag)
        }
    }
    
    private func _moveAnimation(index: Int) {
        if _items.count == 0 {
            return 
        }
        
        UIView.animate(withDuration: 0.3) {
            let w = self._lineView.bounds.width
            self._lineView.frame = CGRect(x: CGFloat(index) * w, y: self.bounds.height - 2, width: w, height: self._lineView.bounds.height)
        }
    }
    
    override func moveTo(index: Int) {
        _moveAnimation(index: index)
    }
    
    override func scrollOffset(x: CGFloat, contentWidth: CGFloat) {
        if isShowLineView {
            let w = self._lineView.bounds.width
            _lineView.frame = CGRect(x: x * w / contentWidth, y: self.bounds.height - 2, width: w, height: _lineView.bounds.height)
        }
    }
    
    private func _widthWith(s: String, fontSize: CGFloat, height: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: s).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
}
