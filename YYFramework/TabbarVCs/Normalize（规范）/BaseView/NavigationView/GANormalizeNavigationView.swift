//
//  GANormalizeNavigationView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/24.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

enum GANormalizeNavigationViewButtonType: Int {
    case left = 0, otherLeft = 1, right = 2
}
protocol GANormalizeNavigationViewDelegate: class {
    func normalizeNavigationViewClicked(type: GANormalizeNavigationViewButtonType)
}

class GANormalizeNavigationView: UIView {
    
    weak var delegate: GANormalizeNavigationViewDelegate?
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var leftOtherButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var navigationBackView: UIView!
    
    @IBOutlet weak var titleLabelLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var titleLabelRightSpace: NSLayoutConstraint!
    @IBOutlet weak var lineViewHeight: NSLayoutConstraint!
    
    typealias ButtonHandler = (_ title: String) -> ()
    private var rightButtonHandler: ButtonHandler?
    
    public var isShowLineView: Bool! {
        didSet {
            lineViewHeight.constant =  1.0 / UIScreen.main.scale
            lineView.isHidden = !isShowLineView
        }
    }
    
    public var isShowLeftButton: Bool = true {
        didSet {
            leftButton.isHidden = !isShowLeftButton
            
            _updateTitleLableSpace()
        }
    }
    
    public var isShowLeftOtherButton: Bool = false {
        didSet {
            leftOtherButton.isHidden = !isShowLeftOtherButton
            
            _updateTitleLableSpace()
        }
    }
    
    public var isShowRightButton: Bool = false {
        didSet {
            rightButton.isHidden = !isShowRightButton
            _updateTitleLableSpace()
        }
    }
    
    private func _updateTitleLableSpace() {
        if isShowLeftButton {
            titleLabelLeftSpace.constant = 44.0
            titleLabelRightSpace.constant = 44.0
        } else if isShowLeftOtherButton {
            titleLabelLeftSpace.constant = 100.0
            titleLabelRightSpace.constant = 100.0
        } else {
            titleLabelLeftSpace.constant = 0
            titleLabelRightSpace.constant = 0
        }
    }
    
    @IBAction func navigationButtonsAction(_ sender: UIButton) {
        guard let type = GANormalizeNavigationViewButtonType(rawValue: sender.tag) else {
            return
        }
        delegate?.normalizeNavigationViewClicked(type: type)
        
        if type == .right {
            if let rHandler = rightButtonHandler {
                rHandler(sender.titleLabel?.text ?? "")
            }
        }
    }
    
    public func nav_show(isShowLineView line: Bool = false, isShowLeftButton left: Bool = true, isShowLeftOtherButton leftOther: Bool = false, isShowRightButton right: Bool = false) {
        
        isShowLineView = line
        
        isShowLeftButton = left
        isShowLeftOtherButton = leftOther
        isShowRightButton = right

    }
    
    public func nav_show(customerView: UIView) {
        customerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(customerView)
        self.nav_addLayout(top: 0, bottom: 0, left: 0, right: 0, item: customerView)
    }
    
    public func nav_showNavigationRightButton(title: String = "", imgName: String = "", buttonHandler: @escaping (_ title: String) -> ()) {
        isShowRightButton = true
        
        rightButton.setTitle(title, for: .normal)
        rightButton.setImage(UIImage(named: imgName), for: .normal)
        
        rightButtonHandler = buttonHandler
    }
    
    static func loadNavigationView() -> GANormalizeNavigationView {
        return Bundle.main.loadNibNamed("GANormalizeNavigationView", owner: self, options: nil)?.last as! GANormalizeNavigationView
    }
    
}

extension UIView {
    func nav_addLayout(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat, item: UIView) {
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
    }
}
