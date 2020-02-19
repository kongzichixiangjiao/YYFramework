//
//  TogetherImage.swift
//  YYFramework
//
//  Created by houjianan on 2019/9/3.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class TogetherImageViewController: GANavViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.brown
        
        b_showNavigationView(title: "拼接图片")
        _togeterImages()
    }
    
    private func _togeterImages() {
        guard let upImg = UIImage(named: "album1") else { return  }
        
        guard let downImg = UIImage(named: "img_001.jpg") else { return }
        
        let img = UIImage.ga_compose(upImg: upImg, downImg: downImg, w: kScreenWidth)
        
        let imgV = UIImageView(image: img)
        imgV.frame = CGRect(x: 0, y: kStatusBarHeight + kNavigationHeight, width: kScreenWidth, height: (downImg.size.height + upImg.size.height)  * kScreenWidth / kScreenHeight)
        self.view.addSubview(imgV)
    }
    
   

}

