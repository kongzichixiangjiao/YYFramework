//
//  GALayoutKitViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/17.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
//import LayoutKit

class GALayoutKitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let image = SizeLayout<UIImageView>(width: 50, height: 50, config: { imageView in
//            imageView.image = UIImage(named: "img_001.jpg")
//        })
//        
//        let label = LabelLayout(text: "Hello World!", alignment: .center)
//        
//        let stack = StackLayout(
//            axis: .horizontal,
//            spacing: 40,
//            sublayouts: [image, label]
//        )
//        
//        let insets = UIEdgeInsets(top: 40, left: 20, bottom: 4, right: 8)
//        let helloWorld = InsetLayout(insets: insets, sublayout: stack)
//        helloWorld.arrangement().makeViews(in: self.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

