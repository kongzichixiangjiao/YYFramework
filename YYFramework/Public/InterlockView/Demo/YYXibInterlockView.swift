//
//  YYXibInterlockView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/10/10.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class YYXibInterlockView: UIView {

    @IBOutlet weak var headerViewTop: NSLayoutConstraint!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentSizeWidth: NSLayoutConstraint!
    @IBOutlet weak var scrollViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollUpView: UIView!
    
    var vcs: [UIViewController] = []
    
    static func loadXibInterlockView() -> YYXibInterlockView {
        return Bundle.main.loadNibNamed("YYXibInterlockView", owner: self, options: nil)?.last as! YYXibInterlockView
    }
    
    func configUI(headerView: UIView?, vcs: [UIViewController]) {
        scrollView.delegate = self
        self.vcs = vcs 
        for i in 0..<vcs.count {
            let vc = vcs[i]
            guard let view = vc.view else {
                return
            }
            vc.yy_scrollView?.delegate = self
            _ = self.frame.size.width
            let viewH = view.size.height - headerViewHeight.constant
            view.frame = CGRect(x: CGFloat(i) * kScreenWidth, y: 0, width: kScreenWidth, height: viewH)
            scrollUpView.addSubview(view)
        }
        
        contentSizeWidth.constant = CGFloat(vcs.count) * self.frame.size.width
    }
    
}

extension YYXibInterlockView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        if scrollView.tag == 1 && y != 0 {
            scrollView.contentOffset = CGPoint.zero
            return
        }
        
        
        print(y)
        
        let _ = self.vcs[0]
        if y <= 0 {
//            vc.yy_scrollView?.contentOffset = CGPoint(x: 0, y: 0)
        } else {
            
        }
//        scrollViewTop.constant = -y
        headerViewTop.constant = -y
        
    }
}
