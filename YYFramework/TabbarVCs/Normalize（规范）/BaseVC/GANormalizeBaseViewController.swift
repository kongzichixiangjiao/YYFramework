//
//  GAGANormalizeBaseViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/24.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

// 导航栏动画
protocol GANormalizeBaseNavigationAnimationProtocol {
    func base_navigationViewAnimation(y: CGFloat)
}

class GANormalizeBaseViewController: UIViewController {
    // @IBOutlet weak public var
    @IBOutlet weak var base_topLayout: NSLayoutConstraint!
    
    public var base_title: String = "" // 导航栏的标题
    public var base_isShowNavigationView: Bool = true  //是否展示导航栏
    public var base_isShowTabbarView: Bool = false // 是否展示出tabbarView
    public var base_isNavigationViewAnimation: Bool = false    // 导航栏是否有简单的动画
    
    public lazy var navigationView: GANormalizeNavigationView = {
        let v = GANormalizeNavigationView.loadNavigationView()
        v.bounds = CGRect.zero
        v.delegate = self
        v.isShowLineView = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kMainBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initViews()
    }
    
    public func initViews() {
        _updateXibTopSpace()
        _initNavigationView()
    }
    
    private func _initNavigationView() {
        if base_isShowNavigationView {
            navigationView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kStatusBarHeight + kNavigationHeight)
            navigationView.titleLable.text = base_title
            navigationView.theme_backgroundColor = "Global.backgroundColor"
            self.view.addSubview(navigationView)
        }
    }
    
    /*
     *  有导航 base_topLayout距离导航栏底部的距离
     *  无导航 base_topLayout距离状态栏底部
     */
    private func _updateXibTopSpace() {
        if (base_topLayout != nil) {
            if base_isShowNavigationView {
                base_topLayout.constant += (kStatusBarHeight + kNavigationHeight)
            } else {
                base_topLayout.constant += kStatusBarHeight
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension GANormalizeBaseViewController: GANormalizeBaseHUDProtocol {
    func base_showHUD(message: String) {
        /*
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.show(withStatus: message)
         */
    }
    
    func base_dismissHUD() {
        /*
        SVProgressHUD.dismiss(withDelay: 0.1)
         */
    }
}

extension GANormalizeBaseViewController: GANormalizeBaseToastProtocol {
    func base_showToast(message: String) {
        
    }
    
    func base_hideToast() {
        
    }
}

extension GANormalizeBaseViewController: GANormalizeNavigationViewDelegate {
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
    
    func normalizeNavigationViewCustomerView() -> UIView? {
        return nil
    }
}
