//
//  GABasicAnimationViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/16.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GABasicAnimationViewController: GANavViewController {
    
    var pView: YYPlayerView = {
        let v = YYPlayerView.loadPlayerView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "PlayerView全屏")
        
        pView.delegate = self
        pView.frame = CGRect(x: 0, y: 400, width: self.view.width, height: 400)
        self.view.addSubview(pView)
        pView.urlString = "https://qiniu.puxinasset.com/5e3c23c4d9545e5aabe1e3ff6cefac65.mp4"
    }
    
    @IBAction func playerViewAnimation(_ sender: Any) {
        pView.fullState = .full
        GAPlayerWindow.share.enterFullScreen(v: pView)
    }
    
    @objc func hide() {
        GAPlayerWindow.share.exitFullScreen(subView: pView)
    }
    
}

extension GABasicAnimationViewController: YYPlayerViewDelegate {
    func playerView(playerSate: YYPlayerState) {
        
    }
    
    func playerViewClickedFullButton(state: YYPlayerScreenState) {
        if state == .full {
            GAPlayerWindow.share.enterFullScreen(v: pView)
        } else {
            GAPlayerWindow.share.exitFullScreen(subView: pView)
            pView.frame = CGRect(x: 0, y: 400, width: self.view.width, height: 400)
        }
    }
}
