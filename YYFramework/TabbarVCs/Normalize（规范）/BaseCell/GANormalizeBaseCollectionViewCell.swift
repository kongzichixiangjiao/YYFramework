//
//  GANormalizeBaseCollectionViewCell.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/13.
//  Copyright © 2019年 houjianan. All rights reserved.
//

/*
 *  1、
 *  所有CollectionViewCell 继承 GANormalizeBaseCollectionViewCell
 *  xib配置_isShowBottomLineView即可
 *  2、
 *  xib里面自己拖拽view继承YYOnePixView
 */

import UIKit

class GANormalizeBaseCollectionViewCell: UICollectionViewCell {
    
    @IBInspectable var _isShowBottomLineView: Bool = false
    @IBInspectable var _marginSpaceBottomLineView: CGFloat = 16
    
    lazy var _bottomLineView: UIView = {
        let v = UIView()
        v.backgroundColor = kSeptalLine_1_LevelColor
        v.translatesAutoresizingMaskIntoConstraints = false 
        return v
    }()
    
    var isShowBottomLineView: Bool! {
        didSet {
            _bottomLineView.isHidden = !isShowBottomLineView
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _initBottomLineView()
    }
    
    private func _initBottomLineView() {
        if _isShowBottomLineView {
            self.contentView.addSubview(_bottomLineView)
            
            self.contentView.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 0))
            self.contentView.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: _marginSpaceBottomLineView))
            self.contentView.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -_marginSpaceBottomLineView))
            _bottomLineView.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 1.0 / UIScreen.main.scale))
        }
    }
}
