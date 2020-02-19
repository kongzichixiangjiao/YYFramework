//
//  YYXibTabBarItem.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/14.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

protocol YYXibTabBarItemDelegate: class {
    func YYXibTabBarItemTap(title: String, tag: Int) -> Bool
}

@IBDesignable
class YYXibTabBarItem: UIView {
    
    weak var mDelegate: YYXibTabBarItemDelegate?
    
    @IBInspectable var backViewColor: UIColor = UIColor.black
    
    @IBInspectable var imageDefaultName: String = ""
    @IBInspectable var imageHighlightName: String = ""
    
    @IBInspectable var labelName: String = ""
    @IBInspectable var labelFontSize: CGFloat = 10
    @IBInspectable var labelNormalColor: String = "B2B2B2"
    @IBInspectable var labelSelectedColor: String = "1361A6"
    
    @IBInspectable var imageTopSpace: CGFloat = 8
    @IBInspectable var labelTopSpace: CGFloat = 33
    
    @IBInspectable var mTag: Int = -1
    
    var isHighlight: Bool! {
        didSet {
            if isHighlight && !imageHighlightName.isEmpty {
                imageV.image = UIImage(named: self.imageHighlightName)
                mLabel.textColor = self.labelSelectedColor.tabbarItem_color0X
            } else {
                imageV.image = UIImage(named: self.imageDefaultName)
                mLabel.textColor = self.labelNormalColor.tabbarItem_color0X
            }
        }
    }
    
    lazy var imageV: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(named: self.imageDefaultName)
        v.contentMode = .scaleAspectFit
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var mLabel: UILabel = {
        let v = UILabel()
        v.font = UIFont.systemFont(ofSize: self.labelFontSize)
        v.textColor = self.labelNormalColor.tabbarItem_color0X
        v.textAlignment = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var button: UIButton = {
        let v = UIButton()
        v.tag = mTag
        v.translatesAutoresizingMaskIntoConstraints = false
        v.addTarget(self, action: #selector(tabbarItemTapAction(sender:)), for: UIControl.Event.touchUpInside)
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = backViewColor
        initViews()
    }
    
    @objc func tabbarItemTapAction(sender: UIButton) {
        guard let b = mDelegate?.YYXibTabBarItemTap(title: labelName, tag: mTag) else {
            return
        }
        
        if b {
            isHighlight = true
        }
    }
    
    private func initViews() {
        if !imageDefaultName.isEmpty {
            self.addSubview(imageV)
            self.addConstraint(NSLayoutConstraint(item: imageV, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: imageTopSpace))
            self.addConstraint(NSLayoutConstraint(item: imageV, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            imageV.addConstraint(NSLayoutConstraint(item: imageV, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 22))
            imageV.addConstraint(NSLayoutConstraint(item: imageV, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 22))
        }
        
        if !labelName.isEmpty {
            self.addSubview(mLabel)
            mLabel.text = labelName
            let c = (!_hasSave() && imageDefaultName.isEmpty) ? labelTopSpace - 20 : labelTopSpace
            self.addConstraint(NSLayoutConstraint(item: mLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: c))
            self.addConstraint(NSLayoutConstraint(item: mLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        }
        
        self.addSubview(button)
        self.tabbarItem_addLayout(top: 0, bottom: 0, left: 0, right: 0, item: button)
    }
    
    private func _hasSave() -> Bool {
        if #available(iOS 11.0, *) {
            guard let _ = UIApplication.shared.delegate?.window??.safeAreaInsets else {
                return false
            }
            return true
        } else {
            return false
        }
    }
}

extension UIView {
    func tabbarItem_addLayout(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat, item: UIView) {
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: item, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: item, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: item, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: item, attribute: .right, multiplier: 1, constant: 0))
    }
}

extension String {
    var tabbarItem_color0X: UIColor! {
        var cString:String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
