//
//  GATagsView+Extension.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/9.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

extension GATagsView {
     func _initLastButtonViews() -> CGFloat {
            let w = self.frame.size.width
            
            let actualW = w - _m.leftSpace - _m.rightSpace
            var tempW: CGFloat = actualW
            var rowW: CGFloat = _m.leftSpace
            
            var row: CGFloat = 0 // 行
            
            for i in 0..<_btnModels.count {
                
                let model = _btnModels[i]
                
                let tH = _m.tagMinHeight
                let sW = model.name.ga_widthWith(_m.fontSize, height: tH)
                let tW = max((sW > tempW ? tempW - (_m.leftSpace + _m.rightSpace) : sW), _m.tagMinWidth) + _m.tagMargin * 2
                
                var tX: CGFloat = 0
                var tY: CGFloat = _m.topSpace
                
                tX = rowW
                tY = _m.topSpace + row * (_m.tagMinHeight + _m.tagRowSpace)
                
                rowW = (tX + tW + _m.tagColumnSpace)
                tempW = actualW - (tX + tW)
                
                if i < _btnModels.count - 1 {
                    let nextText = _btnModels[i + 1].name
                    let nextSw = nextText.ga_widthWith(_m.fontSize, height: tH)
                    let nextTw = max((nextSw > tempW ? tempW - (_m.leftSpace + _m.rightSpace) : nextSw), max(nextSw, _m.tagMinWidth)) + _m.tagMargin * 2
                    
                    if tempW < nextTw {
                        row += 1
                        rowW = _m.leftSpace
                        if _m.maxRows > Int(row) {
                            tempW = actualW
                        }
                    }
                } else {
                    row += 1
                }
                
                if _m.maxRows <= Int(row) {
                    let itemSpace = tempW - tW - _m.tagRowSpace - _m.rightSpace
                    if itemSpace < _m.moreButtonWidth {
                        if _btnModels.count > i + 1 {
                            _initMoreButton(i: i, frame: CGRect(x: tX, y: tY, width: _m.moreButtonWidth, height: tH), model: model)
                        } else {
                            _initMoreTypeButton(i: i, frame: CGRect(x: tX, y: tY, width: tW, height: tH), model: model)
                        }
                    } else {
                        if _btnModels.count > i + 1 {
                            _initMoreButton(i: i, frame: CGRect(x: tX + tW + _m.tagRowSpace, y: tY, width: _m.moreButtonWidth, height: tH), model: model)
                        } else {
                            _initMoreTypeButton(i: i, frame: CGRect(x: tX, y: tY, width: tW, height: tH), model: model)
                        }
                    }
                    
                    let h = tY + tH + _m.bottomSpace
                    
                    return h
                } else {
                    _initMoreTypeButton(i: i, frame: CGRect(x: tX, y: tY, width: tW, height: tH), model: model)
                }
                
            }
            
            let allH = CGFloat(min(_m.maxRows, Int(row))) * _m.tagMinHeight
            let allRowSpace = CGFloat(min(_m.maxRows, Int(row)) - 1) * _m.tagRowSpace
            let h = allH + allRowSpace  + _m.topSpace + _m.bottomSpace

            return h
        }
    
    func _initMoreButton(i: Int, frame: CGRect, model: GATagsButtonModel) {
        _frames.append(frame)
        
        let b = UIButton(type: .custom)
        b.frame = frame
        b.tag = i
        b.layer.cornerRadius = frame.size.height / 2
        b.layer.masksToBounds = true
        let isSelected = _btnModels[i].isSelected
        b.layer.borderWidth = isSelected ? 0 : 1
        b.layer.borderColor = (isSelected ? _m.bSelectedBorderColor : _m.bNormalBorderColor).cgColor

        b.titleLabel?.font = UIFont.systemFont(ofSize: _m.fontSize)
        b.setTitle(_m.moreButtonShow3Title, for: .normal)
        b.setImage(UIImage(named: _m.moreButtonShow3Icon), for: .normal)
        b.imageEdgeInsets = UIEdgeInsets(top: 0, left: 52, bottom: 0, right: 0)
        b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 22)
        
        b.isSelected = isSelected
        b.setBackgroundImage(UIImage.tagsView_init(_m.bNormalBackColor, andFrame: b.bounds), for: .normal)
        b.setBackgroundImage(UIImage.tagsView_init(_m.bSelectedBackColor, andFrame: b.bounds), for: .selected)
        b.setTitleColor(_m.bNormalTextColor, for: .normal)
        b.setTitleColor(_m.bSelectedTextColor, for: .selected)
        
        b.addTarget(self, action: #selector(_bMoreAction), for: .touchUpInside)
        self.addSubview(b)
        
        _buttons.append(b)
    }
    
    func _initMoreTypeButton(i: Int, frame: CGRect, model: GATagsButtonModel) {
        _frames.append(frame)
        
        let b = UIButton(type: .custom)
        
        b.tag = i
        b.layer.cornerRadius = frame.size.height / 2
        b.layer.masksToBounds = true
        let isSelected = _btnModels[i].isSelected
        b.layer.borderWidth = isSelected ? 0 : 1
        b.layer.borderColor = (isSelected ? _m.bSelectedBorderColor : _m.bNormalBorderColor).cgColor
        
        if model.isLast {
            b.titleLabel?.font = UIFont.systemFont(ofSize: _m.fontSize)
            b.setTitle(_m.moreButtonShowAllTitle, for: .normal)
            b.setImage(UIImage(named: _m.moreButtonShowAllIcon), for: .normal)
            b.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: _m.moreButtonWidth, height: frame.size.height)
            b.imageEdgeInsets = UIEdgeInsets(top: 0, left: 52, bottom: 0, right: 0)
            b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 22)
        } else {
            b.titleLabel?.font = UIFont.systemFont(ofSize: _m.fontSize)
            b.setTitle(model.name, for: .normal)
            b.frame = frame
        }
        
        b.isSelected = isSelected
        b.setBackgroundImage(UIImage.tagsView_init(_m.bNormalBackColor, andFrame: b.bounds), for: .normal)
        b.setBackgroundImage(UIImage.tagsView_init(_m.bSelectedBackColor, andFrame: b.bounds), for: .selected)
        b.setTitleColor(_m.bNormalTextColor, for: .normal)
        b.setTitleColor(_m.bSelectedTextColor, for: .selected)
        
        b.addTarget(self, action: #selector(_bMoreTypeAction(b:)), for: .touchUpInside)
        self.addSubview(b)
        
        _buttons.append(b)
    }
    
    // 刷新数据 并返回高度 maxRows展示全部时候尽量写大点
    public func reloadViewsMoreType(btnModels: [GATagsButtonModel], maxRows: Int = 2, clickedHandler: @escaping ClickedHandler) -> CGFloat {

        self._clickedHandler = clickedHandler

        return reloadViewsMoreType(btnModels: btnModels, maxRows: maxRows)
    }
    
    
    public func reloadViewsMoreType(btnModels: [GATagsButtonModel], maxRows: Int = 2) -> CGFloat {
        self._frames.removeAll()
        self._buttons.removeAll()
        
        self._btnModels = btnModels
        self._m.maxRows = maxRows
        
        if maxRows >= 20 {
            let lastModel = GATagsButtonModel()
            lastModel.icon = _m.lastButtonIcon
            lastModel.isLast = true
            self._btnModels.append(lastModel)
        }
        
        for v in self.subviews {
            v.removeFromSuperview()
        }
        
        let h: CGFloat = _initLastButtonViews()
        
        self.frame = CGRect(x: self.origin.x, y: self.origin.y, width: self.frame.width, height: h)
        
        allH = h
        
        return h
    }
    
    @objc private func _bMoreTypeAction(b: UIButton) {
        let bo = _m.isShowLastButton && (b.titleLabel?.text == _m.moreButtonShow3Title || b.titleLabel?.text == _m.moreButtonShowAllTitle)
        if bo {
            
        } else {
            if _m.isRadio {
                for button in _buttons {
                    if button.isSelected {
                        button.isSelected = false
                        button.layer.borderWidth = 1
                        button.layer.borderColor = _m.bNormalBorderColor.cgColor
                    }
                }
            }
            
            b.isSelected = !b.isSelected
            b.layer.borderWidth = b.isSelected ? 0 : 1
            b.layer.borderColor = (b.isSelected ? _m.bSelectedBorderColor : _m.bNormalBorderColor).cgColor
        }
        
        _clickedHandler?(b, _btnModels[b.tag], bo)
    }
    
    @objc private func _bMoreAction(b: UIButton) {
        let m = GATagsButtonModel()
        m.name = _m.moreButtonShow3Title
        _clickedHandler?(b, m, true)
    }
}
