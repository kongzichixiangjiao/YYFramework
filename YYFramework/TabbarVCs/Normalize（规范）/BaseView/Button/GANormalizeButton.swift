//
//  GANormalizeLinearButton.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/23.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

enum GANormalizeButtonTouchState: Int {
    case began = 0, ended = 1
}

enum GANormalizeButtonState: Int {
    case normal = 0, selected = 1, enabled = 2, highlight = 3
}

class GANormalizeButton: UIButton {

    // 是否描边
    @IBInspectable var isLinear: Bool = false
    // 字体大小
    @IBInspectable var mainTitleFontSize: CGFloat = 14
    // 
    @IBInspectable var mainNormalColor: UIColor = kMainButtonDefaultColor!
    @IBInspectable var mainHighlightColor: UIColor = kMainButtonHighlightColor!
    @IBInspectable var mainSelectedColor: UIColor = kMainButtonSelectedColor!
    @IBInspectable var mainDisabledColor: UIColor = kMainButtonDisabledColor!
    
    @IBInspectable var mainNormalTitle: String = ""
    @IBInspectable var mainHighlightTitle: String = ""
    @IBInspectable var mainSelectedTitle: String = ""
    @IBInspectable var mainDisabledTitle: String = ""
    
    @IBInspectable var mainNormalTitleColor: UIColor = UIColor.white
    @IBInspectable var mainHighlightTitleColor: UIColor?
    @IBInspectable var mainSelectedTitleColor: UIColor?
    @IBInspectable var mainDisabledTitleColor: UIColor?
    
    @IBInspectable var mainLineBorderColor: UIColor = kMainButtonDisabledColor!
    @IBInspectable var mainCornerRadius: CGFloat = kCircularBead_2_4_LevelRadius
    
    typealias TargetHandler = (_ touchState: GANormalizeButtonTouchState, _ state: GANormalizeButtonState) -> ()
    private var _beganHandler: TargetHandler?
    private var _endedHandler: TargetHandler?
    
    public func addBeganAction(startState: GANormalizeButtonState = .normal, handler: @escaping TargetHandler) {
        _beganHandler = handler
    }
    public func addEndAction(startState: GANormalizeButtonState = .normal, handler: @escaping TargetHandler) {
        _endedHandler = handler
    }
    
    var stateType: GANormalizeButtonState! {
        didSet {
            switch stateType {
            case .normal?:
                self.isEnabled = true
                self.isHighlighted = false
                self.isSelected = false
                break
            case .selected?:
                self.isEnabled = true
                self.isHighlighted = false
                self.isSelected = true
                break
            case .enabled?:
                self.isEnabled = false
                self.isHighlighted = false
                self.isSelected = false
                break
            case .highlight?:
                self.isEnabled = true
                self.isHighlighted = true
                self.isSelected = false
                break
            case .none:
                self.isEnabled = true
                self.isHighlighted = false
                self.isSelected = false
                break
            }
            _setUp(enabled: self.isEnabled, selected: self.isSelected, highlight: self.isHighlighted)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _updateView()
    }
    
    private func _updateView() {
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: mainTitleFontSize)
        self.layer.cornerRadius = mainCornerRadius
        self.layer.masksToBounds = true
        if isLinear {
            self.layer.borderWidth = kBorderWidth
            self.layer.borderColor = mainLineBorderColor.cgColor
        }
        stateType = .normal
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isEnabled {
            _setUp(enabled: isEnabled, selected: isSelected, highlight: isHighlighted)
        }
        _beganHandler?(.began, stateType)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isEnabled {
            _setUp(enabled: isEnabled, selected: isSelected, highlight: isHighlighted)
        }
        _endedHandler?(.ended, stateType)
    }
    
    private func _setUp(enabled: Bool, selected: Bool, highlight: Bool) {
        if enabled {
            if selected {
                self.backgroundColor = mainSelectedColor
                self.setTitle(_title(t: mainSelectedTitle), for: .normal)
                self.setTitleColor(_titleColor(color: mainSelectedTitleColor), for: .normal)
            }else if highlight {
                self.backgroundColor = mainHighlightColor
                self.setTitle(_title(t: mainHighlightTitle), for: .normal)
                self.setTitleColor(_titleColor(color: mainHighlightTitleColor), for: .normal)
            } else {
                self.backgroundColor = mainNormalColor
                self.setTitle(_title(t: mainNormalTitle), for: .normal)
                self.setTitleColor(_titleColor(color: mainNormalTitleColor), for: .normal)
            }
        } else {
            self.backgroundColor = mainDisabledColor
            self.setTitle(_title(t: mainDisabledTitle), for: .normal)
            self.setTitleColor(_titleColor(color: mainDisabledTitleColor), for: .normal)
        }
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func _title(t: String) -> String {
        if t.isEmpty {
            return mainNormalTitle
        }
        return t 
    }
    
    private func _titleColor(color: UIColor?) -> UIColor {
        guard let c = color else {
            return mainNormalTitleColor
        }
        return c
    }

    deinit {
        
    }
}
