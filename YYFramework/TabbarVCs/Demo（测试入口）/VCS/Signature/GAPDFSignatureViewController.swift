//
//  GAPDFSignatureViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/3/25.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAPDFSignatureViewController: YYBaseViewController {
    
    lazy var contentImageView: UIImageView = {
        let v = UIImageView()
        let pan = UIPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        v.addGestureRecognizer(pan)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinch(sender:)))
        v.addGestureRecognizer(pinch)
        self.view.addSubview(v)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView(title: "PDF")
        
        let webView = DWKWebView(frame: CGRect(x: 0, y: 64, width: kScreenWidth, height: kScreenHeight - 64))
        let url = URL(string: "http://powuou3m8.bkt.clouddn.com/%E9%99%84%E4%BB%B61%EF%BC%9APMP%E8%8B%B1%E6%96%87%E6%8A%A5%E5%90%8D%E6%8C%87%E5%AF%BC%E8%A7%86%E9%A2%91%E8%A7%82%E7%9C%8B%E6%8C%87%E5%BC%95.pdf")
        
        self.view.addSubview(webView)
        let request = URLRequest.init(url: url!)
        webView.load(request)
        
        let b = UIButton()
        navigationView.rightButton = b
        b.addTarget(self, action: #selector(action), for: UIControl.Event.touchUpInside)
    }
    
    
    @objc func action() {
        let vc = YYMosaicViewController(nibName: "YYMosaicViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    // 移动手势方法
    @objc func pan(sender: UIPanGestureRecognizer) {
        let x: CGFloat = self.contentImageView.center.x
        let y: CGFloat = self.contentImageView.center.y
        let translation = sender.translation(in: self.contentImageView)
        sender.view!.center = CGPoint(x: x + translation.x, y: y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.contentImageView)
    }
    // 捏合手势方法
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    
}

extension GAPDFSignatureViewController: YYMosaicViewControllerDelegate {
    func mosaicViewControllerGet(resultsImageView: UIImageView) {
        let image = resultsImageView.image!
        contentImageView.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        contentImageView.image = image
    }
}

