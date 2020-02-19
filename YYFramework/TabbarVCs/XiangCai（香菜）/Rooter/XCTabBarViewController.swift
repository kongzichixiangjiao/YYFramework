//
//  XCTabBarViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/28.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class XCTabBarViewController: UITabBarController {
    
    var specialIndex: Int = 1
    public var vcs: [UIViewController] = []
    private let lu_titles = ["1", "2", "3"]
    private let lu_vcs = [XCHomeViewController(), UIViewController(), XCMineViewController()]
    
    lazy var xibTabBarView: XCTabBarView = {
        let v = XCTabBarView.loadBaseXibTabBarView()
        v.mDelegate = self
        v.frame = CGRect(x: 0, y: 0, width: self.tabBar.bounds.width, height: kTabBarHeight)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        return v
    }()
    
    lazy var specialView: UILabel = {
        let tabbarItemw: CGFloat = self.view.width - self.view.width * 0.3 * 2
        let w: CGFloat = 80.0 
        let v = UILabel(frame: CGRect(x: 0, y: -30, width: w, height: w))
        v.layer.cornerRadius = w / 2
        v.layer.masksToBounds = true
        v.ga_addTapGestureRecognizer(target: self, action: #selector(_specialTap(tap:)))
        v.text = "中间"
        v.textAlignment = .center
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // removeFromView方式，观看图层，层级特别多。
        self.setValue(xibTabBarView, forKey: "tabBar")
        _hideTopLineView()
        
        xibTabBarView.b_tabBarSpecialView(v: specialView, index: specialIndex)
        
        self.delegate = self
        initViewControllers()
        
        for v in xibTabBarView.buttons {
            let itemV = GACircleView(frame: v.frame)
            xibTabBarView.insertSubview(itemV, belowSubview: v)
            views.append(itemV)
        }
    }
    
    var views: [GACircleView] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func initViewControllers() {
        guard let vcs = self.viewControllers else {
            _initLuVC()
            return
        }
        
        _initStoryboardVC(vcs: vcs)
    }
    
    private func _initStoryboardVC(vcs: [UIViewController]) {
        for i in 0..<vcs.count {
            let vc = vcs[i]
            _initVC(vc: vc, tag: i)
        }
        
        self.viewControllers = self.vcs
    }
    
    private func _initLuVC() {
        for i in 0..<lu_vcs.count {
            let title = lu_titles[i]
            xibTabBarView.updateView(title: title, index: i)
            
            let vc = lu_vcs[i]
            _initVC(vc: vc, tag: i)
        }
        
        self.viewControllers = self.vcs
    }
    
    private func _initVC(vc: UIViewController, tag: Int) {
        if NSStringFromClass(type(of: vc)).components(separatedBy: ".").last! == "YYNavigationViewController" ||
            NSStringFromClass(type(of: vc)).components(separatedBy: ".").last! == "UINavigationViewController" {
            vc.xc_vc_tag = tag
            vc.view.backgroundColor = UIColor.randomColor()
            self.vcs.append(vc)
        } else {
            let nav = YYNavigationViewController(rootViewController: vc)
            nav.xc_vc_tag = tag
            vc.view.backgroundColor = UIColor.randomColor()
            self.vcs.append(nav)
        }
    }
    
    public var tabBar_currentVC: UIViewController {
        return self.viewControllers![selectedIndex]
    }
    
    public func willShowVC(clickedIndex d_idnex: Int) -> UIViewController {
        return self.viewControllers![d_idnex]
    }
    
    // 再次点击 刷新当前vc
    public func tabbar_refreshCurrent(vc: UIViewController) {
        
    }
    
    public func tabbar_login(vc: UIViewController, index: Int) {
        
    }
    
    @objc func _specialTap(tap: UITapGestureRecognizer) {
        //        selectedIndex = 2
        let vc = GAPlustViewController(nibName: "GAPlustViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    private func _hideTopLineView() {
        if #available(iOS 13, *) {
            let appearance = self.tabBar.standardAppearance.copy()
            appearance.backgroundImage = UIColor.randomColor().ga_image(viewSize: CGSize(width: self.tabBar.width, height: 1))
            appearance.shadowImage = UIColor.randomColor().ga_image(viewSize: CGSize(width: self.tabBar.width, height: 1))
            appearance.shadowColor = .clear
            //            appearance.configureWithTransparentBackground() // 隐藏topline需要打开注释
            self.tabBar.standardAppearance = appearance
        } else {
            self.tabBar.shadowImage = UIColor.randomColor().ga_image(viewSize: CGSize(width: self.tabBar.width, height: 1))
            self.tabBar.backgroundImage = UIColor.randomColor().ga_image(viewSize: CGSize(width: self.tabBar.width, height: 1))
        }
    }
    
}

extension XCTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        xibTabBarView.b_tabBarVeiwClicked(tag: viewController.xc_vc_tag)
    }
}

extension XCTabBarViewController: YYBaseXibTabBarViewDelegate {
    func base_xibTabBarView(currentIndex c_index: Int, clickedIndex d_index: Int) {
        self.selectedIndex = d_index
        
        tabbar_login(vc: self.vcs[d_index], index: d_index)
        
        let c_v = views[c_index]
        c_v.stop {
            let d_v = self.views[d_index]
            d_v.start()
        }
    }
    
    func base_xibTabBarViewClickedCurrentItem(index: Int) {
        tabbar_refreshCurrent(vc: self.vcs[index])
    }
}

extension UIViewController {
    static var kXCViewControllerKey_tag: UInt = 19112801
    
    var xc_vc_tag: Int {
        set {
            objc_setAssociatedObject(self, &UIViewController.kXCViewControllerKey_tag, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            if let b = objc_getAssociatedObject(self, &UIViewController.kXCViewControllerKey_tag) {
                return b as! Int
            }
            return -2019
        }
    }
}
