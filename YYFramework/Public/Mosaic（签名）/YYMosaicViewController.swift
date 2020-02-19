//
//  YYMosaicViewController.swift
//  YYImageStitching
//
//  Created by 侯佳男 on 2018/6/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

protocol YYMosaicViewControllerDelegate: class {
    func mosaicViewControllerGet(resultsImageView: UIImageView)
}

class YYMosaicViewController: YYBaseViewController {
    
    private let kOrientation: String = "orientation"
    
    weak var delegate: YYMosaicViewControllerDelegate?
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var mosaicView: YYMosaicView!
    @IBOutlet weak var alertImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = "f3f3f3".color0X
        base_showNavigationView(title: "签名", isShow: false)
        
        mosaicView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delegate?.mosaicViewControllerGet(resultsImageView: imageV)
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.ga_mandatoryLandscape = false
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: kOrientation)
        
        self.navigationController?.ga_isEnabledPop(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.ga_isEnabledPop(false)
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.ga_mandatoryLandscape = true
        UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: kOrientation)
        
        mosaic()
    }
    
    func mosaic() {
        let size = CGSize(width: self.view.height, height: self.view.width - 94 - 20)
        mosaicView.surfaceImage = UIColor.white.ga_image(viewSize: size)
        mosaicView.image = UIColor.black.ga_image(viewSize: size)

        mosaicView.setupViews(frame: CGRect(origin: CGPoint(x: 0, y: 54), size: size))
    }
    
    @IBAction func save(_ sender: UIButton) {
        imageV.image = mosaicView.getSaveView()
        imageV.isHidden = !imageV.isHidden
        mosaicView.isHidden = !mosaicView.isHidden
    }
    
    @IBAction func preStep(_ sender: Any) {
        mosaicView.preStep()
    }
    
    @IBAction func reset(_ sender: Any) {
        mosaicView.reset()
        alertImageView.isHidden = false
    }
    
    @IBAction func back(_ sender: Any) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.ga_mandatoryLandscape = false
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: kOrientation)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension YYMosaicViewController: YYMosaicViewDelegate {
    func mosaicViewTouchesBegan() {
        alertImageView.isHidden = true
    }
}

extension YYMosaicViewController {
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .default
//    }
//    
//    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
//        return .slide
//    }
}
