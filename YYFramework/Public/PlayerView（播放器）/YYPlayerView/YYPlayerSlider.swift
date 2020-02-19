//
//  LYPlayerSlider.swift
//
//  Copyright © 2017年 ly_coder. All rights reserved.
//
//  GitHub地址：https://github.com/LY-Coder/LYPlayer
//

import UIKit

protocol YYPlayerSliderDelegate: class {
    func playerSliderBegan(progress: CGFloat)
    func playerSliderChanged(progress: CGFloat)
    func playerSliderEnd(progress: CGFloat)
}

class YYPlayerSlider: UIControl {
    
    weak var delegate: YYPlayerSliderDelegate?
    
    @IBInspectable var defaultProgressColor: UIColor = UIColor.gray
    @IBInspectable var progressColor: UIColor = UIColor.gray
    @IBInspectable var dragColor: UIColor = UIColor.gray
    @IBInspectable var dragWidth: CGFloat = 8.0
    @IBInspectable var progress: CGFloat = 0.0
    @IBInspectable var progressHeight: CGFloat = 2.0
    
    private var isContains: Bool?
    
    var defaultLayer: CAShapeLayer = CAShapeLayer()
    var progressLayer: CAShapeLayer = CAShapeLayer()
    var dragProgressLayer: CAShapeLayer = CAShapeLayer()
    
    var isInitFinished: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        _initLayers()
    }
    
    func _initLayers() {
        
        defaultLayer.fillColor = defaultProgressColor.cgColor
        let defaultPath = UIBezierPath(rect: CGRect(x: 0, y: self.frame.size.height / 2 - progressHeight / 2, width: self.frame.size.width, height: progressHeight))
        defaultLayer.path = defaultPath.cgPath
        self.layer.addSublayer(defaultLayer)
        
        progressLayer.fillColor = progressColor.cgColor
        let path = UIBezierPath(rect: CGRect(x: 0, y: self.frame.size.height / 2 - 2 / 2, width: progress * self.frame.size.width, height: progressHeight))
        progressLayer.path = path.cgPath
        self.layer.addSublayer(progressLayer)
        
        dragProgressLayer.fillColor = dragColor.cgColor
        let dragPath = UIBezierPath(roundedRect: CGRect(x: progress * self.frame.size.width - dragWidth / 2, y: self.frame.size.height / 2 - dragWidth / 2, width: dragWidth, height: dragWidth), cornerRadius: dragWidth / 2)
        dragProgressLayer.path = dragPath.cgPath
        self.layer.addSublayer(dragProgressLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        for touch in touches {
            let point = touch.location(in: self)
            isContains = dragProgressLayer.path?.contains(point)
            progress = point.x / frame.width
            _setupPlayProgressViewWidth(progress: progress)
        }
        delegate?.playerSliderBegan(progress: progress)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            let point = touch.location(in: self)
            if isContains! && point.x > 0 && point.x < frame.width {
                progress = point.x / frame.width
                _setupPlayProgressViewWidth(progress: progress)
                delegate?.playerSliderChanged(progress: progress)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        delegate?.playerSliderEnd(progress: progress)
    }
    
    private func _setupPlayProgressViewWidth(progress: CGFloat) {
        if progress == 0 {
            return
        }
        
        let dragPath = UIBezierPath(roundedRect: CGRect(x: progress * self.frame.size.width - dragWidth / 2, y: self.frame.size.height / 2 - dragWidth / 2, width: dragWidth, height: dragWidth), cornerRadius: dragWidth / 2)
        dragProgressLayer.path = dragPath.cgPath
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: self.frame.size.height / 2 - progressHeight / 2, width: progress * self.frame.size.width, height: progressHeight))
        progressLayer.path = path.cgPath
    }

    public func setupProgress(_ progress: CGFloat) {
        _setupPlayProgressViewWidth(progress: progress)
    }
}
