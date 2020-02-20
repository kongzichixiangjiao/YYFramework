//
//  GALiveDetailsViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/18.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GALiveDetailsViewController: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgPlayerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containtLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    var playerWindow = GAPlayerWindow(frame: UIScreen.main.bounds)
    
    lazy var playerControlView: YYPlayerControlView = {
        let v = "YYPlayerControlView".xibLoadView() as! YYPlayerControlView
        v.backgroundColor = UIColor.clear
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _init_pl_PlayerView()
    }
    
    func _init_pl_PlayerView() {
        let urlS = "https://qiniu.puxinasset.com/2df9faefa553f6f555f177904fd449c9.mp4"
        
        playerControlView.urlString = urlS
        bgPlayerView.addSubview(playerControlView)
        
        bgPlayerView.ga_addLayout(top: 0, left: 0, right: 0, bottom: 0, item: playerControlView, toItem: bgPlayerView)
    }
    
    deinit {
        print("----")
    }
    
}


extension GALiveDetailsViewController: YYPlayerControlViewDelegate {
    func playerControlViewClicked(buttonType: YYPlayerControlViewButtonType, button: UIButton) {
        if buttonType == .fullScreen {
            if button.isSelected {
                playerWindow.exitFullScreen(subView: bgView, isXIB: true)
            } else {
                playerWindow.enterFullScreen(v: bgPlayerView, isXIB: true)
            }
        }
    }
}
