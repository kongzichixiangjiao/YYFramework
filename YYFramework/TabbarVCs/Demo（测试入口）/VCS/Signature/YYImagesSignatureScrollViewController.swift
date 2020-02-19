//
//  YYImagesSignatureScrollViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/3/26.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class YYImagesSignatureScrollViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: self.view.bounds)
        v.delegate = self
        v.backgroundColor = UIColor.white
        v.maximumZoomScale = 3.0
        return v
    }()
    
    lazy var contentView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.orange
        v.isUserInteractionEnabled = true
        return v
    }()
    
    lazy var signatureAreaButton: UIButton = {
        let x: CGFloat = 0.1
        let y: CGFloat = 0.1
        let b = UIButton(frame: CGRect(x: kScreenWidth * x, y: kScreenWidth * y, width: 100, height: 60))
        b.backgroundColor = UIColor.orange
        b.contentMode = UIView.ContentMode.scaleToFill
        b.setTitle("签名区域", for: UIControl.State.normal)
        b.addTarget(self, action: #selector(signatureAreaAction), for: UIControl.Event.touchUpInside)
        return b
    }()
    
    @objc func signatureAreaAction() {
        let vc = YYMosaicViewController(nibName: "YYMosaicViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        self.view.addSubview(scrollView)
        
        let image = UIImage(named: "tianmolei.jpg")
        let count: Int = 5
        var h: CGFloat = 0
        if image!.size.height > image!.size.width {
            h = kScreenWidth * (image!.size.width / image!.size.height)
        } else {
            h = kScreenWidth * (image!.size.height / image!.size.width)
        }
        
        contentView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: h * CGFloat(count))
        
        for i in 0..<5 {
            let v = UIImageView()
            v.isUserInteractionEnabled = true
            v.frame = CGRect(x: 0, y: CGFloat(i) * h + CGFloat(i * 0), width: kScreenWidth, height: h)
            v.image = image
            contentView.addSubview(v)

            if i == 2 {
                v.addSubview(signatureAreaButton)
            }
        }
        scrollView.addSubview(contentView)
        scrollView.contentSize = CGSize(width: kScreenWidth, height: (h + 20) * CGFloat(count))
    }
    
}

extension YYImagesSignatureScrollViewController: YYMosaicViewControllerDelegate {
    func mosaicViewControllerGet(resultsImageView: UIImageView) {
        let image = UIImage.ga_imageRotation(image: resultsImageView.image!, orientation: UIImage.Orientation.left)
        signatureAreaButton.setImage(image, for: UIControl.State.normal)
        signatureAreaButton.setTitle("", for: UIControl.State.normal)
    }
}

extension YYImagesSignatureScrollViewController: UIScrollViewDelegate {

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }
}

