//
//  GATagsView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/8.
//  Copyright © 2019 houjianan. All rights reserved.
//  内容不固定多个按钮排列

/*
lazy var tagsView: GATagsView = {
    let model = GATagsViewModel()
    
    let v = GATagsView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 200), btnModels: data, model: model, clickedHandler: {
        [weak self] btn, model in
        print(btn, model.name, model.isSelected)
    })
    v.backgroundColor = UIColor.randomColor()
    return v
}()

let _ = tagsView.reloadViews(btnModels: data, maxRows: 2)
*/

enum GATagsViewType: Int {
    case normal = 1, more = 2
}

@objc protocol GATagsViewDelegate: class {
    @objc optional func tagsViewReturnNewRowLastView() -> UIView?
    @objc optional func tagsViewClickedConfirm(text: String)
}

class GATagsView: UIView {
    
    weak var delegate: GATagsViewDelegate?
    
    var _btnModels: [GATagsButtonModel] = []
    var _m: GATagsViewModel = GATagsViewModel()
    var _frames: [CGRect] = []
    var _buttons: [UIButton] = []
    
    typealias ClickedHandler = (_ b: UIButton, _ m: GATagsButtonModel, _ isLast: Bool) -> ()
    var _clickedHandler: ClickedHandler?
    
    var allH: CGFloat = 0
    
    convenience init(frame: CGRect, btnModels: [GATagsButtonModel], model: GATagsViewModel, mType: GATagsViewType = .normal, clickedHandler: @escaping ClickedHandler) {
        self.init(frame: frame)
        
        self._m = model
        if mType == .normal {
            let _ = reloadViews(btnModels: btnModels, maxRows: _m.maxRows, clickedHandler: clickedHandler)
        } else {
            let _ = reloadViewsMoreType(btnModels: btnModels, maxRows: _m.maxRows, clickedHandler: clickedHandler)
        }
    }
    
    private func _initViews() -> CGFloat {
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
//                let nextTw = max((nextSw > tempW ? tempW - (_m.leftSpace + _m.rightSpace) : nextSw), _m.tagMinWidth) + _m.tagMargin * 2
                let nextTw = max((nextSw > tempW ? tempW - (_m.leftSpace + _m.rightSpace) : nextSw), max(nextSw, _m.tagMinWidth)) + _m.tagMargin * 2
                
                if tempW < nextTw {
                    row += 1
                    rowW = _m.leftSpace
                    tempW = actualW
                }
            } else {
                row += 1
            }
            
            if _btnModels[i].isLast {
                _initButton(i: i, frame: CGRect(x: tX, y: tY, width: _m.tagMinWidth + _m.tagMargin * 2, height: tH), model: model)
            } else {
                if _m.maxRows <= Int(row) {
                    _initButton(i: i, frame: CGRect(x: tX, y: tY, width: tW, height: tH), model: model)
                    let h = tY + tH + _m.bottomSpace
                    
                    if _m.isShowEditView {
                        _initEditView()
                        return h + _m.editViewHeight + _m.tagRowSpace
                    }
                    
                    return h
                } else {
                    _initButton(i: i, frame: CGRect(x: tX, y: tY, width: tW, height: tH), model: model)
                }
            }
        }
        
        let allH = CGFloat(min(_m.maxRows, Int(row))) * _m.tagMinHeight
        let allRowSpace = CGFloat(min(_m.maxRows, Int(row)) - 1) * _m.tagRowSpace
        let h = allH + allRowSpace  + _m.topSpace + _m.bottomSpace
        
        if _m.isShowEditView {
            _initEditView()
            return h + _m.editViewHeight + _m.tagRowSpace
        }
        
        return h
    }
    
    private func _initEditView() {
        guard let lastFrame = _frames.last else {
            return
        }

        let frame = CGRect(x: _m.leftSpace, y: lastFrame.origin.y + lastFrame.size.height + _m.tagRowSpace, width: _m.editViewWidth, height: _m.editViewHeight)
        if let delegateV = delegate?.tagsViewReturnNewRowLastView?() {
            delegateV.frame = frame 
            self.addSubview(delegateV)
        } else {
            let model = GATagsEditViewModel()
            let v = GATagsEditView(frame: frame, model: model)
            v.delegate = self
            v.layer.cornerRadius = frame.size.height / 2
            v.layer.masksToBounds = true
            v.backgroundColor = "FBFBFB".tagsView_color0X
            self.addSubview(v)
        }
    }
    
    private func _initButton(i: Int, frame: CGRect, model: GATagsButtonModel) {
        _frames.append(frame)
        
        let b = UIButton(type: .custom)
        b.frame = frame
        b.tag = i
        b.layer.cornerRadius = frame.size.height / 2
        b.layer.masksToBounds = true
        let isSelected = _btnModels[i].isSelected
        b.layer.borderWidth = isSelected ? 0 : 1
        b.layer.borderColor = (isSelected ? _m.bSelectedBorderColor : _m.bNormalBorderColor).cgColor
        
        if model.isLast {
            b.setImage(UIImage(named: _m.lastButtonIcon), for: .normal)
        } else {
            b.titleLabel?.font = UIFont.systemFont(ofSize: _m.fontSize)
            b.setTitle(model.name, for: .normal)
        }
        
        b.isSelected = isSelected
        b.setBackgroundImage(UIImage.tagsView_init(_m.bNormalBackColor, andFrame: b.bounds), for: .normal)
        b.setBackgroundImage(UIImage.tagsView_init(_m.bSelectedBackColor, andFrame: b.bounds), for: .selected)
        b.setTitleColor(_m.bNormalTextColor, for: .normal)
        b.setTitleColor(_m.bSelectedTextColor, for: .selected)
        
        b.addTarget(self, action: #selector(_bAction(b:)), for: .touchUpInside)
        self.addSubview(b)
        
        _buttons.append(b)
    }
    
    // 刷新数据 并返回高度
    public func reloadViews(btnModels: [GATagsButtonModel], maxRows: Int = 2, clickedHandler: @escaping ClickedHandler) -> CGFloat {
        self._frames.removeAll()
        self._buttons.removeAll()
        
        self._btnModels = btnModels
        self._m.maxRows = maxRows
        self._clickedHandler = clickedHandler
        
        if _m.isShowLastButton {
            let lastModel = GATagsButtonModel()
            lastModel.icon = _m.lastButtonIcon
            lastModel.isLast = true
            self._btnModels.append(lastModel)
        }
        
        for v in self.subviews {
            v.removeFromSuperview()
        }
        
        let h = _initViews()
        
        self.frame = CGRect(x: self.origin.x, y: self.origin.y, width: self.frame.width, height: h)
        
        allH = h
        
        return h
    }
    
    @objc private func _bAction(b: UIButton) {
        if _m.isShowLastButton && b.tag == _btnModels.count - 1 {
            
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
        
        _clickedHandler?(b, _btnModels[b.tag], _m.isShowLastButton && b.tag == _btnModels.count - 1)
    }
    
}

extension GATagsView: GATagsEditViewDelegate {
    func tagsEditViewClickedConfirm(text: String) {
        delegate?.tagsViewClickedConfirm?(text: text)
    }
}

