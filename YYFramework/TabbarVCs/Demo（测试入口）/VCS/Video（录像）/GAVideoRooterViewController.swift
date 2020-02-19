//
//  GAVideoRooterViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/18.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAVideoRooterViewController: GANavViewController {
    
    @IBOutlet weak var imageV: UIImageView!
    
    var pView: YYPlayerView = {
        let v = YYPlayerView.loadPlayerView()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        b_showNavigationView(title: "视频录制")

        pView.delegate = self
        self.view.addSubview(pView)
    }
    
    @IBAction func systemVideo(_ sender: Any) {
        // 相册、拍照、录像
        let vc = GAOpenSystemCameraViewController(nibName: "GAOpenSystemCameraViewController", bundle: nil)
        vc.cameraType = .photoAlbum
        vc.delegate = self
        yy_push(vc: vc, animated: false)
    }
    
    @IBAction func customVideo(_ sender: Any) {

    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func b_viewDidLayoutSubviews() {
        pView.frame = CGRect(x: 0, y: 200, width: self.view.width, height: 300)
    }
    
}

extension GAVideoRooterViewController: GAOpenSystemCameraViewControllerDelegate {
    // cameraType == .photoAlbum -> Image/Video
    func openSystemCameraViewControllerDidSelected(pickVC: UIImagePickerController?, cameraType: GACameraType, sourceData: Any?) {
        if let image = sourceData as? UIImage {
            imageV.image = image
        }
        
        if let path = sourceData as? String {
            pView.url = URL(fileURLWithPath: path)
        }
    }

    func openSystemCameraViewControllerPresentCompletion(pickVC: UIImagePickerController?, cameraType: GACameraType) {
        
    }
    
    // cameraType == .photos -> Image/Video
    func openSystemCameraViewControllerSaveSuccess(pickVC: UIImagePickerController?, cameraType: GACameraType, sourceData: Any?) {
        
    }
    
    func openSystemCameraViewControllerShowSetting() {
        
    }
    
    func openSystemCameraViewController_is_ShowDefaultAlert() -> Bool {
        return true
    }
    
    func openSystemCameraViewControllerClickedCancle() {
        self.yy_pop()
    }
}

extension GAVideoRooterViewController: YYPlayerViewDelegate {
    func playerView(playerSate: YYPlayerState) {
        
    }
    
    func playerViewClickedFullButton(state: YYPlayerScreenState) {
        if state == .full {
            GAPlayerWindow.share.enterFullScreen(v: pView)
        } else {
            GAPlayerWindow.share.exitFullScreen(subView: self.view)
            pView.frame = CGRect(x: 0, y: 200, width: self.view.width, height: 300)
            self.view.addSubview(pView)
        }
    }
}
