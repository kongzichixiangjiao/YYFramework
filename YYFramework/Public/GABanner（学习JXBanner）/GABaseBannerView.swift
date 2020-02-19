//
//  GABaseBannerView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

// 增加numberOfItemsInSection个数
let kMultiplier = 1000

class GABannerBaseView: UIView {
    // MARK: 使用到的对象
    var pageCount: Int = 0
    
    var model: GABannerModel = GABannerModel()
    
    // 当前Cell
    var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    // func gaBanner(_ banner: GABanner) -> (GABannerCellRegister)
    var cellRegister: GABannerCellRegister = GABannerCellRegister(type: nil, reuseIdentifier: "GABannerBaseCell")
    
    // 自定轮播使用
    var timer: Timer?
    
    // 滚动的样式
    lazy var layout: GABannerBaseFlow = {
        let layout = GABannerBaseFlow()
        layout.model = GABannerLayoutModel()
        return layout
    }()
    
    lazy var placeholderImgView: UIImageView = {
        let placeholder = UIImageView()
        return placeholder
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView =
            UICollectionView(frame: self.bounds, collectionViewLayout: self.layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        //        collectionView.decelerationRate = UIScrollView.DecelerationRate(rawValue: 0.01)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()
    
    lazy var coverView: UIView = {
        let coverView: UIView = UIView()
        coverView.frame = self.bounds
        coverView.isUserInteractionEnabled = false
        coverView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return coverView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.autoresizingMask = []
        _installNotifications()
        _initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _installNotifications()
        _initViews()
    }
    
    // MARK: deinit
    deinit {
        _stop()
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: 子类要重写的方法
extension GABannerBaseView {
    @objc func setScrollCurrentIndex() {
        
    }
    
    @objc func autoScroll() {
        
    }
}

// MARK: 自动滚动相关方法
extension GABannerBaseView{
    func _pause() {
        if let timer = self.timer {
            timer.fireDate = Date.distantFuture
        }
    }
    
    func _resume() {
        timer?.fireDate = Date(timeIntervalSinceNow: model.timeInterval)
    }
    
    func _start() {
        if model.timeInterval > 0,
            model.isAutoPlay,
            pageCount > 1 {
            if timer == nil {
                timer = Timer.banner_scheduledTimer(withTimeInterval: model.timeInterval, repeats: true, block: {(timer) in
                    self.autoScroll()
                })
                RunLoop.current.add(timer!, forMode: .common)
            }
            _resume()
        }
    }
    
    func _stop() {
        timer?.invalidate()
        timer = nil
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview == nil {
            _stop()
        }
    }
}

// MARK: 滚动到哪个位置
extension GABannerBaseView {
    func scrollToIndexPath(_ indexPath: IndexPath, animated: Bool) {

        if model.cycleWay == .forward {
            if indexPath.row >= kMultiplier * pageCount - pageCount{
                currentIndexPath = IndexPath(row: (kMultiplier * pageCount / 2), section: 0)
                scrollToIndexPath(currentIndexPath, animated: false)
                setScrollCurrentIndex()
                _start()
                return
            } else if indexPath.row == -1 + pageCount {
                currentIndexPath = IndexPath(row: (kMultiplier * pageCount / 2) + (pageCount - 1), section: 0)
                scrollToIndexPath(currentIndexPath, animated: false)
                
                setScrollCurrentIndex()
                _start()
                return
            }
        }
        
        if model.isPagingEnabled {
            // 旋转执行一次有偏差
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        }
    }
}

// MARK: App到后台 App到前台通知
extension GABannerBaseView {
    private func _installNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: UIApplication.didBecomeActiveNotification, object: nil
        )
    }
    
    // 退到后台暂停
    @objc func applicationDidEnterBackground(
        _ notification: Notification) {
        _pause()
    }
    
    // 回到前台继续
    @objc func applicationDidBecomeActive(
        _ notification: Notification) {
        guard ga_isShowingOnWindow() != false, pageCount > 1 else {
            return
        }
        _resume()
    }
}

// MARK: initView
extension GABannerBaseView {
    func _initViews() {
        self.addSubview(placeholderImgView)
        self.addSubview(collectionView)
        self.addSubview(coverView)
    }
}
