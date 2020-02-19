//
//  GAControl.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/10.
//  Copyright © 2018年 houjianan. All rights reserved.
//


/*
 001、xib 拖拽配置
 
 002、
 var iConPaceC: GAPageControl!
 iConPaceC = GAPageControl(frame: CGRect(x: 20, y: 200, width: 100, height: 100), currentImageName: "pageControl_selected@2x", defaultImageName: "pageControl_default@2x", maxCount: 6, currentPage: 1, space: 3)
 self.view.addSubview(iConPaceC)
 
 iConPaceC.currentPage = sender.tag
 */

import UIKit

class GAPageControl: UIView {
    @IBInspectable var currentImageName: String = ""
    @IBInspectable var defaultImageName: String = ""
    
    @IBInspectable var currentImageColor: UIColor = UIColor.clear
    @IBInspectable var defaultImageColor: UIColor = UIColor.clear
    
    @IBInspectable var space: CGFloat = 5
    @IBInspectable var maxCount: Int = 6
    
    private var _imageViews: [UIImageView] = []
    
    private var _currentImageW: CGFloat = 4
    private var _currentImageH: CGFloat = 4
    
    private var _imageW: CGFloat = 0
    private var _imageH: CGFloat = 0
    
    private var _allW: CGFloat = 0
    private var _allH: CGFloat = 0
    
    private var _currentImageViewLeftContraint: NSLayoutConstraint!
    
    private var _maxSpace: CGFloat = 0
    
    lazy var currentImageView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .center
        v.translatesAutoresizingMaskIntoConstraints = false
        v.image = UIImage(named: self.currentImageName)
        return v
    }()
    
    lazy var subView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.clear
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    convenience init(frame: CGRect, currentImageName: String, defaultImageName: String, maxCount: Int, currentPage: Int, space: CGFloat = 5) {
        self.init(frame: frame)
        self.maxCount = maxCount
        self.space = space
        self.currentImageName = currentImageName
        self.defaultImageName = defaultImageName
        initViews(currentImageColor: currentImageColor, defaultImageColor: defaultImageColor)
        
        self.currentPage = currentPage
    }
    
    convenience init(frame: CGRect, currentImageColor: UIColor, defaultImageColor: UIColor, maxCount: Int, currentPage: Int, space: CGFloat = 5) {
        self.init(frame: frame)
        self.maxCount = maxCount
        self.space = space
        initViews(currentImageColor: currentImageColor, defaultImageColor: defaultImageColor)
        
        self.currentPage = currentPage
    }
    
    private func initViews(currentImageColor: UIColor = UIColor.white, defaultImageColor: UIColor = UIColor.black) {
        var currentImage: UIImage!
        var defaultImage: UIImage!
        if _isImageIcon() {
            currentImage = UIImage(named: currentImageName)
            defaultImage = UIImage(named: defaultImageName)
            
            _currentImageH = defaultImage?.size.height ?? 0
            _currentImageW = defaultImage?.size.width ?? 0
            
            _addConstraint(v: currentImageView, w: _currentImageW, h: _currentImageH)
        } else {
            currentImageView.layer.cornerRadius = self._currentImageW / 2
            currentImageView.layer.masksToBounds = true
            currentImage = currentImageColor.pageControl_image(viewSize: CGSize(width: _currentImageW, height: _currentImageH))
            defaultImage = defaultImageColor.pageControl_image(viewSize: CGSize(width: _currentImageW, height: _currentImageH))
        }
        
        self.currentImageView.image = currentImage
        
        _maxSpace = max(_currentImageW / 2, space)
        
        _imageH = defaultImage?.size.height ?? 0
        _imageW = defaultImage?.size.width ?? 0
        
        for _ in 0..<maxCount {
            let v = UIImageView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.image = defaultImage
            _imageViews.append(v)
            _allW += _imageW
            _allW += space
        }
        _allH = max(_imageH, _currentImageH)
        
        self.addSubview(subView)
        self.addConstraint(NSLayoutConstraint(item: subView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: subView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        _addConstraint(v: subView, w: _allW, h: _allH)
        
        for i in 0..<maxCount {
            let v = _imageViews[i]
            if !_isImageIcon() {
                v.layer.cornerRadius = _currentImageW / 2
                v.layer.masksToBounds = true
            }
            subView.addSubview(v)
            
            _addConstraint(v: v, w: _imageW, h: _imageH)
            
            let left = CGFloat(i) * (space + _imageW) + _maxSpace / 2
            subView.addConstraint(NSLayoutConstraint(item: v, attribute: .left, relatedBy: .equal, toItem: subView, attribute: .left, multiplier: 1, constant: left))
            subView.addConstraint(NSLayoutConstraint(item: v, attribute: .centerY, relatedBy: .equal, toItem: subView, attribute: .centerY, multiplier: 1, constant: 0))
        }
        
        subView.addSubview(currentImageView)
        _currentImageViewLeftContraint = NSLayoutConstraint(item: currentImageView, attribute: .left, relatedBy: .equal, toItem: subView, attribute: .left, multiplier: 1, constant: CGFloat(currentPage) * (space + _imageW) + space / 2 + _imageW - _currentImageW / 2 - _imageW / 2)
        
        subView.addConstraint(_currentImageViewLeftContraint)
        subView.addConstraint(NSLayoutConstraint(item: currentImageView, attribute: .centerY, relatedBy: .equal, toItem: subView, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
    var currentPage: Int = 0 {
        didSet {
            if self.currentPage == maxCount {
                self.currentPage = 0
            }
            _currentImageViewLeftContraint.constant = CGFloat(currentPage) * (space + _imageW) + space / 2 + _imageW - _currentImageW / 2 - _imageW / 2
            
            UIView.animate(withDuration: 0.1) {
                self.subView.layoutIfNeeded()
            }
        }
    }
    
    private func _addConstraint(v: UIView, w: CGFloat, h: CGFloat) {
        v.addConstraint(NSLayoutConstraint(item: v, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: h))
        v.addConstraint(NSLayoutConstraint(item: v, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: w))
    }
    
    private func _isImageIcon() -> Bool {
        return (!currentImageName.isEmpty && !defaultImageName.isEmpty)
    }
    
}

extension UIColor {
    // 获取纯色图片
    func pageControl_image(viewSize: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(self.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }
}



