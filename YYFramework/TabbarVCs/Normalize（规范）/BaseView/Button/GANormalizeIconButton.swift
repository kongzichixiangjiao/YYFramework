//
//  GANormalizeIconButton.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/15.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

enum GANormalizeIconDirection: Int {
    case top = 0, right = 1, bottom = 2, left = 3
}

class GANormalizeIconButton: UIView {
    
    @IBInspectable var iconName: String = ""
    @IBInspectable var titleString: String = ""
    @IBInspectable var iconDirection: Int = 3
    @IBInspectable var elementSpace: CGFloat = 10
    @IBInspectable var mainCornerRadius: CGFloat = kCircularBead_2_4_LevelRadius
    @IBInspectable var mainLineBorderColor: UIColor = kMainButtonDisabledColor!
    @IBInspectable var iconColor: UIColor!
    
    // 是否描边
    @IBInspectable var isLinear: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _updateView()
        
        _tapGesture()
    }
    
    convenience init(frame: CGRect, iconName: String, titleString: String, iconDirection: GANormalizeIconDirection, elementSpace: CGFloat, mainCornerRadius: CGFloat, mainLineBorderColor: UIColor, iconColor: UIColor) {
        self.init(frame: frame)
        
        self.iconName = iconName
        self.titleString = titleString
        self.iconDirection = iconDirection.rawValue
        self.elementSpace = elementSpace
        self.mainCornerRadius = mainCornerRadius
        self.mainCornerRadius = mainCornerRadius
        self.iconColor = iconColor
        
        _updateView()

        _tapGesture()
    }
    
    typealias TapHandler = () -> ()
    var tapHandler: TapHandler?
    public func p_addTapAction(handler: @escaping TapHandler) {
        tapHandler = handler
    }
    
    public func p_updateIcon(name: String) {
        iconName = name
        
        setNeedsDisplay()
    }
    
    private func _tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(_selfAction))
        self.addGestureRecognizer(tap)
    }
    
    @objc func _selfAction() {
        if tapHandler != nil {
            tapHandler?()
        }
    }
    
    private func _updateView() {
        self.layer.cornerRadius = mainCornerRadius
        self.layer.masksToBounds = true
        if isLinear {
            self.layer.borderWidth = kBorderWidth
            self.layer.borderColor = mainLineBorderColor.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let s: String = titleString
        let sH: CGFloat = 16
        let sW: CGFloat = _widthWith(s: s, 14, height: sH)
        var sX: CGFloat = 40
        var sY: CGFloat = 0
        
        var img: UIImage = UIImage(named: iconName)!
        
        if iconColor != nil {
            img = img.iconButton_imageWithTintColor(tintColor: iconColor, blendMode: CGBlendMode.destinationIn)!
        }
        
        let imgW = img.size.width
        let imgH = img.size.height
        var imgX: CGFloat = 0
        var imgY: CGFloat = 0
        
        switch iconDirection {
        case GANormalizeIconDirection.top.rawValue:
            imgX = rect.width / 2 - imgW / 2
            sX = rect.width / 2 - sW / 2
            
            imgY = (elementSpace + imgH + sH) / 2 - rect.height / 2 // img下面做翻转了
            sY = (rect.height / 2 - (elementSpace + imgH + sH) / 2) + imgH + elementSpace
            break
        case GANormalizeIconDirection.right.rawValue:
            sX = rect.width / 2 - (elementSpace + imgW + sW) / 2
            imgX = sX + sW + elementSpace
            
            imgY = imgH / 2 - rect.height / 2  // img下面做翻转了
            sY = rect.height / 2 - sH / 2
            break
        case GANormalizeIconDirection.bottom.rawValue:
            imgX = rect.width / 2 - imgW / 2
            sX = rect.width / 2 - sW / 2
            
            sY = (rect.height / 2 - (elementSpace + imgH + sH) / 2)
            imgY = -(elementSpace + sY + sH) // img下面做翻转了
            break
        case GANormalizeIconDirection.left.rawValue:
            imgX = rect.width / 2 - (elementSpace + imgW + sW) / 2
            sX = imgX + imgW + elementSpace
            
            imgY = imgH / 2 - rect.height / 2  // img下面做翻转了
            sY = rect.height / 2 - sH / 2
            break
        default:
            break
        }
        
        s.draw(in: CGRect(x: sX, y: sY, width: sW, height: sH), withAttributes: [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)])
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: imgH)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setFillColor(UIColor.black.cgColor)
        context?.setStrokeColor(UIColor.black.cgColor)
        
        context?.draw(img.cgImage!, in: CGRect(x: imgX, y: imgY, width: imgW, height: imgH))
    }
    
    private func _widthWith(s: String, _ fontSize: CGFloat, height: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: s).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
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




