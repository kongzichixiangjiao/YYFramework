//
//  ZHCalendarScrollViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/28.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class ZHCalendarScrollViewController: UIViewController {

    @IBOutlet weak var bottomScrollView: UIScrollView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollUpView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var canlendarView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var canlendarHeight: NSLayoutConstraint!
    @IBOutlet weak var canlendarTop: NSLayoutConstraint!
    @IBOutlet weak var canlendarBottom: NSLayoutConstraint!
    @IBOutlet weak var topViewTop: NSLayoutConstraint!
    @IBOutlet weak var scrollViewTop: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        bottomScrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ZHCalendarScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tag = scrollView.tag
        let y = scrollView.contentOffset.y
        print(y)
        
        if tag == 1 {
            if y < 0 {
                self.scrollView.isScrollEnabled = true
                bottomScrollView.isScrollEnabled = false
            } else {
                
            }
        }
        
        if tag == 2 {
            if y > 0 {
                if y > 50 {
                    print("--- \(-y + 50)")
                    self.scrollView.isScrollEnabled = false
                    bottomScrollView.isScrollEnabled = true
                    self.scrollView.contentOffset = CGPoint(x: 0, y: 50)
                    return
                }
                canlendarTop.constant = -y
                canlendarBottom.constant = -y
                canlendarView.layoutIfNeeded()
            } else {
                self.scrollView.contentOffset = CGPoint.zero
                canlendarTop.constant = 0
                canlendarBottom.constant = 0
                canlendarView.layoutIfNeeded()
            }
        }
    }
}
