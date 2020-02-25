//
//  GAImageFItViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/23.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GAImageFItViewController: GANavViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        b_showNavigationView(title: "图片展示")
        
        let image = UIImage(named: "launchAdTest001.png")
        let iW: CGFloat = image?.width ?? 0
        let iH: CGFloat = image?.height ?? 0
        
        let w = kScreenWidth
        let h = iH * w / iW
        let imgView = UIImageView(image: image)
        imgView.frame = CGRect(x: 0, y: b_navigationViewMaxY, width: w, height: h)
        self.view.addSubview(imgView)
        
    }


}
