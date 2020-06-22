//  GAIconButton.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/15.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

enum GAIconDirection: Int {
    case none = 0, top = 1, right = 2, bottom = 3, left = 4
}

enum GAButtonTouchState: Int {
    case began = 0, ended = 1
}

enum GAButtonState {
    case normal, selected(_ b: Bool), enabled(_ b: Bool), highlight(_ b: Bool)
}

class GAIconButton: UIView {
    
    @IBInspectable var iconName: String = ""
    @IBInspectable var iconColor: UIColor!
    @IBInspectable var iconWidth: CGFloat = -1
    @IBInspectable var iconHeight: CGFloat = -1
    
    @IBInspectable var titleString: String = ""
    @IBInspectable var titleColor: UIColor = UIColor.white
    @IBInspectable var titleFontSize: CGFloat = 14
    /// 按钮的位置
    @IBInspectable var iconDirection: Int = 4
    /// 文案和icon的距离
    @IBInspectable var elementSpace: CGFloat = 10
    @IBInspectable var cornerRadius: CGFloat = 4
    @IBInspectable var borderWidth: CGFloat = 1.0 / UIScreen.main.scale
    /// 是否描边
    @IBInspectable var isLinear: Bool = true
    @IBInspectable var lineBorderColor: UIColor = UIColor.white
    
    @IBInspectable var normalBgColor: UIColor = UIColor.lightText
    @IBInspectable var highlightBgColor: UIColor = UIColor.lightText
    @IBInspectable var selectedBgColor: UIColor = UIColor.lightText
    @IBInspectable var disabledBgColor: UIColor = UIColor.lightText
    
    @IBInspectable var normalTitle: String = ""
    @IBInspectable var highlightTitle: String = ""
    @IBInspectable var selectedTitle: String = ""
    @IBInspectable var disabledTitle: String = ""
    
    @IBInspectable var normalTitleColor: UIColor!
    @IBInspectable var highlightTitleColor: UIColor!
    @IBInspectable var selectedTitleColor: UIColor!
    @IBInspectable var disabledTitleColor: UIColor!
    /// 是否可以点击
    @IBInspectable private(set) var isEnabled: Bool = true
    @IBInspectable private(set) var isSelected: Bool = false
    @IBInspectable private(set) var isHighlight: Bool = false
    
    typealias TargetHandler = (_ touchState: GAButtonTouchState, _ state: GAButtonState) -> ()
    private var _beganHandler: TargetHandler?
    private var _endedHandler: TargetHandler?
    
    private var _clickedStartState: GAButtonState = .normal
    
    var stateType: GAButtonState = .normal {
        didSet {
            switch stateType {
            case .normal:
                setupNormal()
                break
            case .selected(let b):
                if b {
                    setupSelected()
                } else {
                    setupNormal()
                }
                isSelected = b
                break
            case .enabled(let b):
                if b {
                    setupNormal()
                } else {
                    setupEnabled()
                }
                isEnabled = b
                break
            case .highlight(let b):
                if b {
                    setupHightlight()
                } else {
                    setupNormal()
                }
                isHighlight = b
                break
            }
        }
    }
    
    func setupNormal() {
        self.backgroundColor = normalBgColor
        self.titleColor = normalTitleColor == nil ? self.titleColor : normalTitleColor
        self.titleString = normalTitle.isEmpty ? self.titleString : normalTitle
    }
    
    func setupSelected() {
        self.backgroundColor = selectedBgColor
        self.titleColor = selectedTitleColor == nil ? self.titleColor : selectedTitleColor
        self.titleString = selectedTitle.isEmpty ? self.titleString : selectedTitle
    }
    
    func setupEnabled() {
        self.backgroundColor = disabledBgColor
        self.titleColor = disabledTitleColor == nil ? self.titleColor : disabledTitleColor
        self.titleString = disabledTitle.isEmpty ? self.titleString : disabledTitle
    }
    
    func setupHightlight() {
        self.backgroundColor = highlightBgColor
        self.titleColor = highlightTitleColor == nil ? self.titleColor : highlightTitleColor
        self.titleString = highlightTitle.isEmpty ? self.titleString : highlightTitle
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _updateView()
    }
    
    convenience init(frame: CGRect,
                     iconName: String = "",
                     titleString: String = "",
                     iconDirection: GAIconDirection = .right,
                     elementSpace: CGFloat = 10,
                     cornerRadius: CGFloat = 4,
                     lineBorderColor: UIColor = UIColor.lightText,
                     iconColor: UIColor = UIColor.lightText,
                     normalBgColor: UIColor = UIColor.lightText,
                     highlightBgColor: UIColor = UIColor.lightText,
                     selectedBgColor: UIColor = UIColor.lightText,
                     disabledBgColor: UIColor = UIColor.lightText,
                     normalTitle: String = "",
                     highlightTitle: String = "",
                     selectedTitle: String = "",
                     disabledTitle: String = "",
                     normalTitleColor: UIColor = UIColor.lightText,
                     highlightTitleColor: UIColor = UIColor.lightText,
                     selectedTitleColor: UIColor = UIColor.lightText,
                     disabledTitleColor: UIColor = UIColor.lightText,
                     isEnabled: Bool = true,
                     isSelected: Bool = true,
                     isHighlight: Bool = true) {
        self.init(frame: frame)
        
        self.iconName = iconName
        self.titleString = titleString
        self.iconDirection = iconDirection.rawValue
        self.elementSpace = elementSpace
        self.cornerRadius = cornerRadius
        self.cornerRadius = cornerRadius
        self.iconColor = iconColor
        self.normalBgColor = normalBgColor
        self.highlightBgColor = highlightBgColor
        self.selectedBgColor = selectedBgColor
        self.disabledBgColor = disabledBgColor
        self.normalTitle = normalTitle
        self.highlightTitle = highlightTitle
        self.selectedTitle = selectedTitle
        self.disabledTitle = disabledTitle
        self.normalTitleColor = normalTitleColor
        self.highlightTitleColor = highlightTitleColor
        self.selectedTitleColor = selectedTitleColor
        self.disabledTitleColor = disabledTitleColor
        self.isEnabled = isEnabled
        self.isSelected = isSelected
        self.isHighlight = isHighlight
        
        _updateView()
    }
    
    public func addBeganAction(handler: @escaping TargetHandler) {
        _beganHandler = handler
    }
    
    public func addEndAction(handler: @escaping TargetHandler) {
        _endedHandler = handler
    }
    
    public func ga_update(imgName: String?, titleString: String?) {
        if let imgName = imgName {
            iconName = imgName
        }
        if let titleString = titleString {
            self.titleString = titleString
        }
        
        setNeedsDisplay()
    }
    
    public func ga_changeIsSelected(_ b: Bool) {
        self.stateType = .selected(b)
    }
    
    private func _updateView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        if isLinear {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = lineBorderColor.cgColor
        }
        _updateState()
    }
    
    private func _updateState() {
        if isEnabled {
            if isSelected {
                stateType = .selected(true)
            } else {
                stateType = .normal
            }
        } else {
            stateType = .enabled(false)
        }
    }
    
    private func _elementSpace() -> CGFloat {
        return (iconName.isEmpty ? 0 : elementSpace)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isEnabled {
            stateType = .highlight(true)
        } else {
            
        }
        _beganHandler?(.began, stateType)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if isEnabled {
            stateType = .normal
        } else {
            
        }
        _endedHandler?(.ended, stateType)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let font = UIFont.systemFont(ofSize: titleFontSize)
        
        let s: String = titleString
        let sH: CGFloat = font.lineHeight
        let sW: CGFloat = _widthWith(s: s, titleFontSize, height: sH)
        var sX: CGFloat = 40
        var sY: CGFloat = 0
        
        var img = UIImage(named: iconName)
        
        if iconColor != nil {
            if let image = img {
                img = image.iconButton_imageWithTintColor(tintColor: iconColor, blendMode: CGBlendMode.destinationIn)!
            }
        }
        
        let imgW = min(img?.size.width ?? 0, iconWidth == -1 ? self.frame.size.width : iconWidth)
        let imgH = min(img?.size.height ?? 0, iconHeight == -1 ? self.frame.size.width : iconHeight)
        var imgX: CGFloat = 0
        var imgY: CGFloat = 0
        
        switch iconDirection {
        case GAIconDirection.top.rawValue:
            imgX = rect.width / 2 - imgW / 2
            sX = rect.width / 2 - sW / 2
            
            imgY = (_elementSpace() + imgH + sH) / 2 - rect.height / 2 // img下面做翻转了
            sY = (rect.height / 2 - (_elementSpace() + imgH + sH) / 2) + imgH + _elementSpace()
            break
        case GAIconDirection.right.rawValue:
            sX = rect.width / 2 - (_elementSpace() + imgW + sW) / 2
            imgX = sX + sW + _elementSpace()
            
            imgY = imgH / 2 - rect.height / 2  // img下面做翻转了
            sY = rect.height / 2 - sH / 2
            break
        case GAIconDirection.bottom.rawValue:
            imgX = rect.width / 2 - imgW / 2
            sX = rect.width / 2 - sW / 2
            
            sY = (rect.height / 2 - (_elementSpace() + imgH + sH) / 2)
            imgY = -(_elementSpace() + sY + sH) // img下面做翻转了
            break
        case GAIconDirection.left.rawValue:
            imgX = rect.width / 2 - (_elementSpace() + imgW + sW) / 2
            sX = imgX + imgW + _elementSpace()
            
            imgY = imgH / 2 - rect.height / 2  // img下面做翻转了
            sY = rect.height / 2 - sH / 2
            break
        case GAIconDirection.none.rawValue:
            sX = rect.width / 2 - sW / 2
            sY = rect.height / 2 - sH / 2
            break
        default:
            break
        }
        
        s.draw(in: CGRect(x: sX, y: sY, width: sW, height: sH),
               withAttributes: [NSAttributedString.Key.foregroundColor : titleColor,
                                NSAttributedString.Key.font : font])
        
        guard let imgCG = img?.cgImage else {
            return
        }
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: imgH)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setFillColor(UIColor.black.cgColor)
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.draw(imgCG, in: CGRect(x: imgX, y: imgY, width: imgW, height: imgH))
    }
    
    private func _widthWith(s: String, _ fontSize: CGFloat, height: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: s).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude,
                                                                 height: height),
                                                    options: .usesLineFragmentOrigin,
                                                    attributes: [NSAttributedString.Key.font: font],
                                                    context: nil)
        return ceil(rect.width)
    }
    
}

extension UIImage {
    func iconButton_imageWithTintColor(tintColor: UIColor, blendMode: CGBlendMode = .destinationIn) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        tintColor.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        self.draw(in: bounds, blendMode: blendMode, alpha: 1.0)
        if blendMode != .destinationIn {
            self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        }
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
}




