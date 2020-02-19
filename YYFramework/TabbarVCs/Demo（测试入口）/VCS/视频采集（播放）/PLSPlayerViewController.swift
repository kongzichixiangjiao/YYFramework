//
//  PLSPlayerViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/3.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class PLSPlayerViewController: GANavViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    var name: String = ""
    
    var pView: YYPlayerView = {
        let v = YYPlayerView.loadPlayerView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "播放视频")
        
        pView.frame = CGRect(x: 0, y: 100, width: self.view.width, height: 400)
        pView.delegate = self
        self.view.addSubview(pView)
        pView.url = name.pl_getFilePath(reservationNumber: kPLVideo_test_yydh)
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pView.releasePlayer()
    }
}

extension PLSPlayerViewController: YYPlayerViewDelegate {
    func playerView(playerSate: YYPlayerState) {
        
    }
    
    func playerViewClickedFullButton(state: YYPlayerScreenState) {
        if state == .full {
            GAPlayerWindow.share.enterFullScreen(v: pView)
        } else {
            GAPlayerWindow.share.exitFullScreen(subView: self.view)
            pView.frame = CGRect(x: 0, y: 100, width: self.view.width, height: 400)
            self.view.addSubview(pView)
        }
    }
}

