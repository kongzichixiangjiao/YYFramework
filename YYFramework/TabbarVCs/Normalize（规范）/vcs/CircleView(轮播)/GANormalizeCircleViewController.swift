//
//  GANormalizeCircleViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/21.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormalizeCircleViewController: UIViewController {
    
    let images = [UIImage(named: "ic_close")!, UIImage(named: "ic_code")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(reuseCollectionView)
    }
    
    lazy var reuseCollectionView: YYReuseCollectionView = {
        let v = YYReuseCollectionView(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height: 300), allPage: images.count)
        v.delegate = self
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    deinit {
        #if DEBUG
        print("GANormalizeCircleViewController")
        #endif
    }
}

extension GANormalizeCircleViewController: YYReuseCollectionViewDelegate {
    func reuseCollectionViewClicked(row: Int) {
        print(row)
    }
    
    func reuseCollectionViewGetImage(row: Int) -> UIImage {
        return images[row]
    }
}
