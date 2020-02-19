//
//  GABannerViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/2.
//  Copyright © 2019 houjianan. All rights reserved.
//  轮播 banner

import UIKit
import AVKit

class GABannerViewController: GANavViewController {
    
    var dataSource = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg"]
    
    lazy var banner: GABannerView = {
        let v = GABannerView(frame: CGRect(x: 0, y: 100, width: self.view.width, height: 250))
        v.delegate = self
        v.dataSource = self
        v.identifier = "test"
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    lazy var px_banner: GAPXBanner? = {
        let v = GAPXBanner(frame: CGRect(x: 0, y: 400, width: self.view.width, height: 134))
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "Banner")
        
        self.view.backgroundColor = UIColor.randomColor()
        
        self.view.addSubview(banner)
        
        self.view.addSubview(px_banner!)
    }
    
    func showPlayerWindow() {
        GAPlayerWindow.share.enterFullScreen(v: px_banner!.pView)
    }
    
    func hidePlayerWindow() {
        GAPlayerWindow.share.exitFullScreen(subView: px_banner!.pView)
        
        self.px_banner?.reloadCellView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    deinit {
        print("GABannerViewController")
    }
}

extension GABannerViewController: GAPXBannerDelegate {
    func bannerDelegateClickedFullScreen(state: YYPlayerScreenState, player: YYPlayerView) {
        if state == .full {
//            GAPlayerWindow.share.enterFullScreen(v: player)
            let vc = GAFullScreenPlayerViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.targetView = player
            self.present(vc, animated: true, completion: nil)
            
//            let vc = AVPlayerViewController()
//            vc.player = player.mPlayer.player
//            self.present(vc, animated: true, completion: nil)
            
        } else {
            self.dismiss(animated: false) {
                self.px_banner?.reloadCellView()
            }
//            GAPlayerWindow.share.exitFullScreen(subView: player)
//            self.px_banner?.reloadCellView()
        }
    } 
}

extension GABannerViewController: GABannerDelegate, GABannerDataSource {
    func gaBanner(_ banner: GABanner, coverView: UIView) {
        
    }
    
    func gaBanner(_ banner: GABanner, center index: Int) {
        
    }
    
    func gaBanner(_ banner: GABanner, model: GABannerModel) -> GABannerModel {
        return model
            .timeInterval(3)
            .cycleWay(.forward)
    }
    
    func gaBanner(_ banner: GABanner, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func gaBanner(_ banner: GABanner) -> (GABannerCellRegister) {
        return GABannerCellRegister(type: GABannerBaseCell.self, reuseIdentifier: GABannerBaseCell.identifier, nib: UINib(nibName: GABannerBaseCell.identifier, bundle: nil))
    }
    
    func gaBanner(_ banner: GABanner, cellForItemAt index: Int, cell: UICollectionViewCell) -> UICollectionViewCell {
        let name = dataSource[index % 6]
        (cell as! GABannerBaseCell).imgView.image = UIImage(named: name)
        return cell
    }
    
    func gaBanner(numberOfItems banner: GABanner) -> Int {
        return dataSource.count
    }
    
    func gaBanner(_ banner: GABanner, layoutModel: GABannerLayoutModel) -> GABannerLayoutModel {
        return layoutModel
            .layoutType(GABannerLinearTransform())
            .itemSize(CGSize(width: 280, height: 250))
            .maximumAngle(0.1)
            .itemSpacing(10)
    }
}
