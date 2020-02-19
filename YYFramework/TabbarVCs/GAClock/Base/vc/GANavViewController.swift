//
//  GANavViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/26.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GANavViewController: GAViewController {
    
    // 设置到顶部距离为 50.0 则距离导航栏最下面距离为50.0
    @IBOutlet weak var b_saveTopSpace: NSLayoutConstraint?
    
    // 是否展示导航栏(对外只读，对内读写)
    private(set) var _isShowNavigationView: Bool = false
    // 是否展示导航栏底部分割线
    public var b_isShowNavigationBottomView: Bool = true

    // 导航View
    lazy var b_navigationView: GANormalizeNavigationView = {
        let v = GANormalizeNavigationView.loadNavigationView()
        v.delegate = self
        v.isShowLineView = self.b_isShowNavigationBottomView
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // 安全距离+导航高度
    public var b_navigationViewMaxY: CGFloat {
      if _isShowNavigationView {
          return kNavigationHeight + GASafeTopHeight
      } else {
          return GASafeTopHeight
      }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func _saveTopSpaceUpdate() {
        if let saveTopSpace = b_saveTopSpace {
            saveTopSpace.constant = kNavigationHeight + saveTopSpace.constant
        }
    }
    
    public func b_showNavigationView(title: String = "", isShow: Bool = true) {
        _isShowNavigationView = isShow
        _initNavigationView(title: title)
        
        _saveTopSpaceUpdate()
    }
    
    public func b_showNavigationRightButton(title: String = "", imgName: String = "", buttonHandler: @escaping (_ title: String) -> ()) {
        b_navigationView.nav_showNavigationRightButton(title: title, imgName: imgName, buttonHandler: buttonHandler)
    }

    private func _initNavigationView(title: String) {
      if _isShowNavigationView {
          self.view.addSubview(b_navigationView)
          self.view.addConstraint(NSLayoutConstraint(item: b_navigationView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
          self.view.addConstraint(NSLayoutConstraint(item: b_navigationView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
          self.view.addConstraint(NSLayoutConstraint(item: b_navigationView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
          b_navigationView.addConstraint(NSLayoutConstraint(item: b_navigationView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kNavigationHeight + GASafeTopHeight))
          
          b_navigationView.titleLable.text = title
      }
    }
    
    public override func b_updateNavigationViewLayout(type: UIInterfaceOrientation) {
        for constraint in b_navigationView.constraints {
            if constraint.firstAttribute == .height {
                constraint.constant = (type == .landscapeLeft || type ==  .landscapeRight) ? kLandscapeNavigationHeight : kNavigationHeight
                b_navigationView.setNeedsLayout()
            }
        }
    }
    
    public func b_clickedLeftButtonAction() {
        guard let nav = self.navigationController else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        nav.popViewController(animated: true)
    }
    
}

extension GANavViewController: GANormalizeNavigationViewDelegate {
    func normalizeNavigationViewClicked(type: GANormalizeNavigationViewButtonType) {
        switch type {
        case .left:
            b_clickedLeftButtonAction()
            break
        case .otherLeft:
            break
        case .right:
            break
        }
    }
    
    func normalizeNavigationViewCustomerView() -> UIView? {
        return nil
    }
}
