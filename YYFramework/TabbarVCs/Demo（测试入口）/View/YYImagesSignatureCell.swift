//
//  YYImagesSignatureCell.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/3/26.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol YYImagesSignatureCellDelegate: class {
    func imagesSignatureCellClickedSignatureArea()
}
class YYImagesSignatureCell: UITableViewCell {
    
    weak var delegate: YYImagesSignatureCellDelegate?
    
    var model: [String : Any]! {
        didSet {
            if let image = model["imageData"] as? UIImage {
                signatureAreaButton.setImage(image, for: UIControl.State.normal)
                signatureAreaButton.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    lazy var sourceImageView: UIImageView = {
        let v = UIImageView()
        v.frame = CGRect(x: 0, y: 40, width: kScreenWidth, height: 300)
        v.image = UIImage(named: "tianmolei.jpg")
        v.isUserInteractionEnabled = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        v.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(sender:)))
        v.addGestureRecognizer(pinch)
        return v
    }()
    
    // 移动手势方法
    @objc func pan(sender: UIPanGestureRecognizer) {
        let x: CGFloat = sourceImageView.center.x
        let y: CGFloat = sourceImageView.center.y
        let translation = sender.translation(in: sourceImageView)
        sender.view!.center = CGPoint(x: x + translation.x, y: y + translation.y)
        sender.setTranslation(CGPoint.zero, in: sourceImageView)
    }
    // 捏合手势方法
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addSubview(sourceImageView)
        sourceImageView.addSubview(signatureAreaButton)
    }
    lazy var signatureAreaButton: UIButton = {
        let b = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 25))
        b.backgroundColor = UIColor.orange
        b.contentMode = UIView.ContentMode.scaleToFill
        b.setTitle("签名区域", for: UIControl.State.normal)
        b.addTarget(self, action: #selector(signatureAreaAction), for: UIControl.Event.touchUpInside)
        return b
    }()
    
    @objc func signatureAreaAction() {
        delegate?.imagesSignatureCellClickedSignatureArea()
    }
    
}
