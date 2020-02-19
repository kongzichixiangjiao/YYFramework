//
//  GAImageView.swift
//  YYFramework
//
//  Created by houjianan on 2019/7/11.
//  Copyright © 2019 houjianan. All rights reserved.
//  有loading的ImageView



/*
 let v = GAImageView()
 v.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
 v.backgroundColor = UIColor.orange
 v.ga_imageView_showSystemLoading(maskColor: "123431".color0X(0.3))
 self.view.addSubview(v)
 
 let v1 = GAImageView()
 v1.frame = CGRect(x: 0, y: 200, width: 100, height: 100)
 v1.backgroundColor = UIColor.orange
 v1.ga_imageView_showSystemLoading()
 self.view.addSubview(v1)
 */


import UIKit

protocol GAShowLoadingProtocol {
    func ga_imageView_showSystemLoading()
    func ga_imageView_hideSystemLoading()
}

class GAImageView: UIImageView, GAShowLoadingProtocol {
    
    lazy var imageView_maskView: UIView = {
        let v = UIView(frame: self.bounds)
        return v
    }()
    
    lazy var imageView_active: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView(style: .white)
        v.startAnimating()
        return v
    }()
    
    func ga_imageView_showSystemLoading() {
        _updateFrame()
        imageView_maskView.addSubview(imageView_active)
        self.insertSubview(imageView_maskView, at: 99)
    }
    
    func ga_imageView_showSystemLoading(maskColor: UIColor) {
        _updateFrame()
        imageView_maskView.backgroundColor = maskColor
        imageView_maskView.addSubview(imageView_active)
        self.insertSubview(imageView_maskView, at: 99)
    }
    
    func ga_imageView_hideSystemLoading() {
        imageView_active.removeFromSuperview()
        imageView_maskView.removeFromSuperview()
    }
    
    private func _updateFrame() {
        imageView_maskView.frame = self.bounds
        imageView_active.center = CGPoint(x: imageView_maskView.bounds.width / 2, y: imageView_maskView.bounds.height / 2)
    }
}
