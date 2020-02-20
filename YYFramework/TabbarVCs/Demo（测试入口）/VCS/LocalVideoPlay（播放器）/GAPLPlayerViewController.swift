//
//  GAPLPlayerViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/17.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GAPLPlayerViewController: UIViewController {
    
    @IBOutlet weak var bgPlayerView: UIView!
    
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
    var playerWindow = GAPlayerWindow(frame: UIScreen.main.bounds)
}

extension GAPLPlayerViewController: PLPlayerDelegate {
    
}

extension GAPLPlayerViewController: YYPlayerControlViewDelegate {
    func playerControlViewClicked(buttonType: YYPlayerControlViewButtonType, button: UIButton) {
        if buttonType == .fullScreen {
            guard let v = bgPlayerView else {
                return
            }
            if button.isSelected {
                playerWindow.exitFullScreen(subView: self.view, isXIB: true)
            } else {
                playerWindow.enterFullScreen(v: v, isXIB: true)
            }
            
            //        if button.isSelected {
            //            let vc = GAFullScreenPlayerViewController()
            //            vc.modalPresentationStyle = .fullScreen
            //            vc.isXib = true
            //            vc.targetView = bgPlayerView
            //            self.present(vc, animated: true, completion: nil)
            //        } else {
            //            self.dismiss(animated: true, completion: {
            //                self.view.addSubview(self.bgPlayerView)
            //                for layout in self.bgPlayerView.constraints {
            //                    if (layout.firstItem as? NSObject == self.bgPlayerView && layout.firstAttribute == NSLayoutConstraint.Attribute.height) {
            //                        layout.constant = 300
            //                    }
            //                    if (layout.firstItem as? NSObject == self.bgPlayerView && layout.firstAttribute == NSLayoutConstraint.Attribute.width) {
            //                        layout.constant = kScreenWidth - 20
            //                    }
            //                }
            //                self.view.addConstraint(NSLayoutConstraint(item: self.bgPlayerView!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
            //                self.view.addConstraint(NSLayoutConstraint(item: self.bgPlayerView!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
            //                self.view.addConstraint(NSLayoutConstraint(item: self.bgPlayerView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: kScreenWidth - 20))
            //                self.view.addConstraint(NSLayoutConstraint(item: self.bgPlayerView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300))
            //            })
            //        }
        }
    }
}
