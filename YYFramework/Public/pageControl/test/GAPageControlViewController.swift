//
//  GAPageControlViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/10.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class GAPageControlViewController: UIViewController {
    
    @IBOutlet weak var pageC: GAPageControl!
    @IBOutlet weak var pageControl: GAColletionViewPageControl!
    @IBOutlet weak var stackView: UIStackView!
    
    var iConPaceC: GAPageControl!
    
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iConPaceC = GAPageControl(frame: CGRect(x: 20, y: 200, width: 100, height: 100), currentImageName: "pageControl_selected@2x", defaultImageName: "pageControl_default@2x", maxCount: 6, currentPage: 1, space: 3)
        self.view.addSubview(iConPaceC)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        count += 1
        if count == 5{
            count = 0
        }
        update()
    }
    
    func update() {
        UIView.animate(withDuration: 0.3) {
            for i in 0..<self.stackView.arrangedSubviews.count {
                let v = self.stackView.arrangedSubviews[i] as! UIImageView
                if i == self.count {
                    v.image = UIImage(named: "tabbar_mine_default")
                } else {
                    v.image = UIImage(named: "page_control_point")
                }
            }
        }
    }
    
    @IBAction func action(_ sender: UIButton) {
        print(sender.tag)
        pageControl.currentPage = sender.tag
        pageC.currentPage = sender.tag
        iConPaceC.currentPage = sender.tag 
    }
    
    
}


