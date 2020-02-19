//
//  UITableView+PlaceHolder.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/26.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  感谢 微博@iOS程序犭袁

/*
    001、// 必须实现numberOfSections代理方法
 
    002、self.tableView.emptyDelegate = self
 
    // 刷新使用yy_reloadData()
    003、self.tableView.yy_reloadData()
 
    004、// 实现代理UITableViewPlaceHolderDelegate方法
 extension <#UIViewController#>: UITableViewPlaceHolderDelegate {
    func tableViewPlaceHolderView() -> UIView {
        let v = <#UIView#>
        return v
    }
 
    func tableViewEnableScrollWhenPlaceHolderViewShowing() -> Bool {
        return <#true#>
    }
 }
 */

import UIKit

enum UIScrollViewHolderType: Int {
    case empty = 0, noNetwork = 1
}

protocol UITableViewPlaceHolderDelegate {
    func tableViewPlaceHolderView() -> UIView
    func tableViewEnableScrollWhenPlaceHolderViewShowing() -> Bool
    func tableViewClickedPlaceHolderViewRefresh()
    func tableViewPlaceHolder_NoNetWork_View() -> UIView?
}

extension UITableView {
    
    static var k_t_EmptyDelegateKey: UInt = 149001
    static var k_t_ScrollWasEnabledKey: UInt = 149002
    static var k_t_PlaceHolderViewKey: UInt = 149003
    
    var scrollWasEnabled: Bool {
        set {
            objc_setAssociatedObject(self, &UITableView.k_t_ScrollWasEnabledKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &UITableView.k_t_ScrollWasEnabledKey) as! Bool
        }
    }
    
    var placeHolderView: UIView? {
        set {
            objc_setAssociatedObject(self, &UITableView.k_t_PlaceHolderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let v = objc_getAssociatedObject(self, &UITableView.k_t_PlaceHolderViewKey) as? UIView
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapTableView))
            v?.addGestureRecognizer(tap)
            return v
        }
    }
    
    var emptyDelegate: UITableViewPlaceHolderDelegate? {
        set {
            objc_setAssociatedObject(self, &UITableView.k_t_EmptyDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &UITableView.k_t_EmptyDelegateKey) as? UITableViewPlaceHolderDelegate
        }
    }
    
    public func ga_reloadData() {
        self.reloadData()
        self.yy_judgeEmpty()
    }
    
    private func yy_judgeEmpty() {
        self.scrollWasEnabled = self.isScrollEnabled
        
        removeView()
        
        if isEmpty() {
            placeholderView(type: .empty)
        }
        
//        if netWorkManager.isReachable {
//            if isEmpty() {
//                placeholderView(type: .empty)
//            }
//        } else {
//            if isEmpty() {
//                placeholderView(type: .noNetwork)
//            }
//        }
    }
    
    private func isEmpty() -> Bool {
        var isEmpty: Bool = true
        let src = self.dataSource
        let sections = src?.numberOfSections!(in: self) ?? 1
        for i in 0..<sections {
            if let row = src?.tableView(self, numberOfRowsInSection: i) {
                if row > 0 {
                    isEmpty = false
                }
            }
        }
        return isEmpty
    }
    
    private func placeholderView(type: UIScrollViewHolderType) {
        if let emptyDelegate = self.emptyDelegate {
            self.isScrollEnabled = emptyDelegate.tableViewEnableScrollWhenPlaceHolderViewShowing()
            if (type == .empty) {
                self.placeHolderView = emptyDelegate.tableViewPlaceHolderView()
            } else {
                if let v = emptyDelegate.tableViewPlaceHolder_NoNetWork_View() {
                    self.placeHolderView = v
                } else {
                    let img = UIImage(named: "new_noInternet")
                    let imgV = UIImageView(image: img)
                    imgV.isUserInteractionEnabled = true
                    imgV.frame = self.bounds
                    imgV.contentMode = .center
                    self.placeHolderView = imgV
                }
            }
            self.placeHolderView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            if let placeHolderView = self.placeHolderView {
                self.addSubview(placeHolderView)
            } else {
                print("UITableView+PlacerHolder yy_judgeEmpty() 没有view")
            }
        } else {
            print("UITableView+PlacerHolder yy_judgeEmpty() 没遵守代理")
        }
    }
 
    private func removeView() {
        self.isScrollEnabled = true
        self.placeHolderView?.removeFromSuperview()
        self.placeHolderView = nil
    }
    
    @objc private func tapTableView() {
        emptyDelegate?.tableViewClickedPlaceHolderViewRefresh()
    }
}


@objc protocol UICollectionViewPlaceHolderDelegate: class {
    func collectionViewPlaceHolderView() -> UIView
    func collectionViewEnableScrollWhenPlaceHolderViewShowing() -> Bool
    @objc optional func collectionViewPlaceHolderViewFrame() -> CGRect
    func collectionViewPlaceHolder_NoNetWork_View() -> UIView?
    func collectionViewClickedPlaceHolderViewRefresh()
}

extension UICollectionView {
    
    static var k_c_EmptyDelegateKey: UInt = 149004
    static var k_c_ScrollWasEnabledKey: UInt = 149005
    static var k_c_PlaceHolderViewKey: UInt = 149006
    
    var scrollWasEnabled: Bool {
        set {
            objc_setAssociatedObject(self, &UICollectionView.k_c_ScrollWasEnabledKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &UICollectionView.k_c_ScrollWasEnabledKey) as! Bool
        }
    }
    
    var placeHolderView: UIView? {
        set {
            objc_setAssociatedObject(self, &UICollectionView.k_c_PlaceHolderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            let v = objc_getAssociatedObject(self, &UICollectionView.k_c_PlaceHolderViewKey) as? UIView
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapCollectionView))
            v?.addGestureRecognizer(tap)
            return v
        }
    }
    
    var emptyDelegate: UICollectionViewPlaceHolderDelegate? {
        set {
            objc_setAssociatedObject(self, &UICollectionView.k_c_EmptyDelegateKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &UICollectionView.k_c_EmptyDelegateKey) as? UICollectionViewPlaceHolderDelegate
        }
    }
    
    public func ga_reloadData() {
        self.reloadData()
        self.yy_judgeEmpty()
    }
    
    private func yy_judgeEmpty() {
        self.scrollWasEnabled = self.isScrollEnabled
        
        removeView()
        
//        if isEmpty() {
//            placeholderView(type: .empty)
//        }
        
        if netWorkManager.isReachable {
            if isEmpty() {
                placeholderView(type: .empty)
            }
        } else {
            if isEmpty() {
                placeholderView(type: .noNetwork)
            }
        }
    }
    
    private func isEmpty() -> Bool {
        var isEmpty: Bool = true
        let src = self.dataSource
        let sections = src?.numberOfSections!(in: self) ?? 1
        for i in 0..<sections {
            if let row = src?.collectionView(self, numberOfItemsInSection: i) {
                if row > 0 {
                    isEmpty = false
                }
            }
        }
        return isEmpty
    }
    
    private func placeholderView(type: UIScrollViewHolderType) {
        if let emptyDelegate = self.emptyDelegate {
            self.isScrollEnabled = emptyDelegate.collectionViewEnableScrollWhenPlaceHolderViewShowing()
            if (type == .empty) {
                self.placeHolderView = emptyDelegate.collectionViewPlaceHolderView()
            } else {
                if let v = emptyDelegate.collectionViewPlaceHolder_NoNetWork_View() {
                    self.placeHolderView = v
                } else {
                    let img = UIImage(named: "new_noInternet")
                    let imgV = UIImageView(image: img)
                    imgV.isUserInteractionEnabled = true
                    imgV.frame = self.bounds
                    imgV.contentMode = .center
                    self.placeHolderView = imgV
                }
            }
            self.placeHolderView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            if let placeHolderView = self.placeHolderView {
                self.addSubview(placeHolderView)
            } else {
                print("UITableView+PlacerHolder yy_judgeEmpty() 没有view")
            }
        } else {
            print("UITableView+PlacerHolder yy_judgeEmpty() 没遵守代理")
        }
    }
    
    private func removeView() {
        self.isScrollEnabled = true
        self.placeHolderView?.removeFromSuperview()
        self.placeHolderView = nil
    }
    
    
    @objc private func tapCollectionView() {
        emptyDelegate?.collectionViewClickedPlaceHolderViewRefresh()
    }
}

struct UIScrollViewKey {
    static var kNetWorkManager: UInt = 20180831
}

import Alamofire
extension UIScrollView {
    var netWorkManager: NetworkReachabilityManager {
        set {
            objc_setAssociatedObject(self, &UIScrollViewKey.kNetWorkManager, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let n = objc_getAssociatedObject(self, &UIScrollViewKey.kNetWorkManager)  else {
                return NetworkReachabilityManager(host: "www.baidu.com")!
            }
            return n as! NetworkReachabilityManager
        }
    }
}
