//
//  GAPXBanner.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/10.
//  Copyright © 2019 houjianan. All rights reserved.
//

/*
 
 lazy var px_banner: GAPXBanner = {
    let v = GAPXBanner(frame: CGRect(x: 0, y: 400, width: self.view.width, height: 134))
     v.delegate = self
     return v
 }()
 
extension <#Controller#>: GAPXBannerDelegate {
    func bannerDelegateClickedFullScreen(state: YYPlayerScreenState, player: YYPlayerView) {
        if state == .full {
            // 跳转全屏
            let vc = GAFullScreenPlayerViewController()
            vc.pView = player
            self.navigationController?.pushViewController(vc, animated: false)
            // 当前界面全屏
//            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//            appdelegate.ga_mandatoryLandscape = true
//            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
//
//            self.px_banner.pView.frame = self.view.bounds
//            self.view.addSubview(self.px_banner.pView)
        } else {

//            let appdelegate = UIApplication.shared.delegate as! AppDelegate
//            appdelegate.ga_mandatoryLandscape = false
//            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            
            for vc in self.navigationController?.viewControllers ?? [] {
                if vc.ga_nameOfClass == "GAFullScreenPlayerViewController" {
                    self.px_banner.reloadCellView()
                    vc.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
*/

import UIKit

protocol GAPXBannerDelegate: class {
    func bannerDelegateClickedFullScreen(state: YYPlayerScreenState, player: YYPlayerView)
}

class GAPXBanner: UIView {
    
    weak var delegate: GAPXBannerDelegate?
    
    var pView: YYPlayerView = {
        let v = YYPlayerView.loadPlayerView()
        return v 
    }()
    
    var currentIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView: UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.autoresizingMask = []
        
        _initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        _initViews()
    }
    
    func _initViews() {
        pView.delegate = self
        
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.yy_register(nibName: GAPXBannerCell.identifier)
        
        currentIndexPath = IndexPath(item: 5000, section: 0)
        collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: false)
        
    }
    
    var isShowPlayer: Bool = false
    func _removePlayer() {
        if isShowPlayer {
            pView.playerSate = .pause
            pView.removeFromSuperview()
        }
    }
    
    func reloadCellView() {
        for cell in collectionView.visibleCells {
            let row = (cell as! GAPXBannerCell).row
            if row == currentIndexPath.row {
                pView.frame = cell.contentView.bounds
                cell.contentView.addSubview(pView)
            }
        }
    }
    
    deinit {
        _removePlayer()
    }
}

extension GAPXBanner: YYPlayerViewDelegate {
    func playerView(playerSate: YYPlayerState) {
        
    }
    
    func playerViewClickedFullButton(state: YYPlayerScreenState) {
        delegate?.bannerDelegateClickedFullScreen(state: state, player: pView)
        
        collectionView.scrollToItem(at: currentIndexPath, at: .centeredHorizontally, animated: false)
    }
}

extension GAPXBanner: GAPXBannerCellDelegate {
    func bannerCellPlay(cell: GAPXBannerCell, row: Int) {
        pView.urlString = "https://qiniu.puxinasset.com/59cb9f75a170aeb3f6f144849aeb85fe.mp4"
        pView.frame = cell.contentView.bounds 
        cell.contentView.addSubview(pView)
        isShowPlayer = true
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate
extension GAPXBanner: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)  -> Int {
        return 10000
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)  -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GAPXBannerCell.identifier, for: indexPath) as! GAPXBannerCell
        var named = ""
        if indexPath.row % 2 == 0 {
            named = "px_banner_002"
        } else {
            named = "px_banner_001"
        }
        cell.row = indexPath.row 
        cell.mDelegate = self
        cell.imgView.image = UIImage(named: named)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 2 == 0 {
            return CGSize(width: 252, height: 134)
        } else {
            return CGSize(width: 197, height: 134)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: UIScrollViewDelegate
extension GAPXBanner {
    // 获取currentIndexPath
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        var b: Bool = false
        if velocity.x > 0 {
            currentIndexPath = currentIndexPath + 1
            b = true
        } else if velocity.x < 0 {
            currentIndexPath = currentIndexPath - 1
            b = true
        } else {
            
        }
        
        if b {
            _removePlayer()
        }
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        scrollToIndexPath(currentIndexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}

// MARK: 滚动到哪个位置
extension GAPXBanner {
    func scrollToIndexPath(_ indexPath: IndexPath, animated: Bool) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
    }
}
