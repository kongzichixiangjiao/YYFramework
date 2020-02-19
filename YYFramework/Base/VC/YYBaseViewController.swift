//
//  YYBaseViewController.swift
//  YYFramework
//
//  Created by houjianan on 2018/8/12.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

public let kLandscapeNavigationHeight: CGFloat = 30

public let kLandscapeTabBarHeight: CGFloat = 30

class YYBaseViewController: UIViewController {
    
    // 是否展示导航栏
    var isShowNavigationView: Bool = false
    //
    var kNavigationViewBottomSpace: CGFloat = 0
    
    private var currentType: UIInterfaceOrientation?
    
    lazy var rootVC: YYRootViewController? = {
        let vc = self.parent
        let vcString = vc?.base_nameOfClass
        if (vcString == "UITabBarController") {
            let tab = vc as! UITabBarController
            return tab.parent as? YYRootViewController
        } else if (vcString == "UINavigationViewController") {
            let nav = vc as! UINavigationController
            let tab = vc?.parent as! UITabBarController
            return tab.parent as? YYRootViewController
        }
        return YYRootViewController()
    }()

    lazy var navigationView: GANormalizeNavigationView = {
        let v = GANormalizeNavigationView.loadNavigationView()
        v.delegate = self
        v.isShowLineView = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
  
//    public var kNavigationViewTop: CGFloat = UIApplication.shared.statusBarFrame.height
//    public var kNavigationViewTop: CGFloat = 0
    
    public var kNavigationViewHeight: CGFloat {
        for constraint in navigationView.constraints {
            if constraint.firstAttribute == .height {
                return constraint.constant
            }
        }
        return 0
    }
    
    public var kNavigationViewMaxY: CGFloat {
        if isShowNavigationView {
            return kNavigationHeight + kStatusBarHeight
        } else {
            return kStatusBarHeight
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        addDeviceOrientationNotification()
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    public func base_showNavigationView(title: String = "", isShow: Bool = true) {
        isShowNavigationView = isShow
        initNavigationView(title: title)
    }
    
    public func base_navigationViewHiddenBackButton() {
        navigationView.leftButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func initNavigationView(title: String) {
        if isShowNavigationView {
            self.view.addSubview(navigationView)
            self.view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
            navigationView.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: kNavigationHeight + kStatusBarHeight))
            
            navigationView.titleLable.text = title
        }
    }
    
    public func base_showNavigationView(customerView: UIView) {
        navigationView.nav_show(customerView: customerView)
    }
    
    @objc func applicationWillChangeStatusBarOrientationNotification(sender: Notification) {
        let type = UIInterfaceOrientation(rawValue: sender.userInfo?[UIApplication.statusBarOrientationUserInfoKey] as! Int)
        if currentType == type {
            return
        }
        applicationWillChangeStatusBarOrientation(type: type!)
        currentType = type
    }
    
    private func applicationWillChangeStatusBarOrientation(type: UIInterfaceOrientation) {
        updateNavigationViewLayout(type: type)
    }
    
    public func updateNavigationViewLayout(type: UIInterfaceOrientation) {
        for constraint in navigationView.constraints {
            if constraint.firstAttribute == .height {
                constraint.constant = (type == .landscapeLeft || type ==  .landscapeRight) ? kLandscapeNavigationHeight : kNavigationHeight + kStatusBarHeight
                navigationView.setNeedsLayout()
            }
        }
    }
    
    private func addDeviceOrientationNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillChangeStatusBarOrientationNotification(sender:)),
                                               name: UIApplication.willChangeStatusBarOrientationNotification,
                                               object: nil)
    }
    
    private func removeDeviceOrientationNotification() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willChangeStatusBarOrientationNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        removeDeviceOrientationNotification()
        print("baseVC deinit")
    }
}

extension YYBaseViewController: GANormalizeNavigationViewDelegate {
    func normalizeNavigationViewClicked(type: GANormalizeNavigationViewButtonType) {
        switch type {
        case .left:
            guard let nav = self.navigationController else {
                return
            }
            nav.popViewController(animated: true)
            break
        case .otherLeft:
            break
        case .right:
            break
        }
    }
}

public extension NSObject{
    class var base_nameOfClass: String {
        // NSStringFromClass(self) 获得的是项目名.类名
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var base_nameOfClass: String{
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}
