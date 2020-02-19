//
//  GACalenderController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

enum GAScrollDirection: Int {
    case up = 1, down = 2, normal = 0
}

class GACalenderController3: GANavViewController {
    
    private let kTopViewHeight: CGFloat = 270
    
    var isMainScrollView: Bool = true
    var isMScrollView: Bool = false
    var scrollMaxY: CGFloat = 20
    
    var currentScrollDirection: GAScrollDirection = .normal
        
    lazy var mainScrollView: GAScrollView = {
        let v = GAScrollView()
        v.delegate = self
        v.tag = 1
        v.frame = CGRect(x: 0, y: kNavigationHeight, width: self.view.bounds.width, height: self.view.bounds.height - kNavigationHeight)
        v.backgroundColor = UIColor.randomColor()
        v.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 2)
        v.scroll_delegate = self
        return v
    }()
    
    lazy var mScrollView: GAScrollView = {
        let v = GAScrollView()
        v.delegate = self
        v.tag = 2
        v.frame = CGRect(x: 0, y: self.kTopViewHeight, width: self.view.bounds.width, height: self.view.bounds.height - kTopViewHeight)
        v.backgroundColor = UIColor.randomColor()
        v.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + 200)
        v.scroll_delegate = self
        return v
    }()
    
    lazy var itemView: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 150)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var itemView1: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.width, height: 100)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var itemView2: GADemoView = {
        let v = GADemoView()
        v.frame = CGRect(x: 0, y: 100, width: self.view.width, height: 100)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "联动")
        
        self.view.addSubview(mainScrollView)
        mainScrollView.addSubview(mScrollView)
        
        itemView.text = "2222222"
        mScrollView.addSubview(itemView)
        
        itemView.text = "111111"
        mainScrollView.addSubview(itemView1)
        
        itemView2.text = "333333333"
        mainScrollView.addSubview(itemView2)
        
    }
    
}


extension GACalenderController3: UIScrollViewDelegate, GAScrollViewDelegate {
    
    func scroll_gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let v = gestureRecognizer.view else {
            return true
        }
        let tag = v.tag
        let scrollView = (v as! UIScrollView)
        _ = scrollView.contentOffset.y
        print("tag = ", tag)
        let mY = mScrollView.contentOffset.y
        _ = mainScrollView.contentOffset.y
        
//        if mY > 0 {
//            if tag == 1 {
//                return false
//            }
//        }
//        if mainY < 0 {
//            if tag == 2 {
//                return false
//            }
//        }
//        if mainY == 0 && mY == 0 {
//            if tag == 2 {
//                if currentScrollDirection == .up {
//                    return false
//                }
//                return true
//            }
//            if tag == 1 {
//
//                return true
//            }
//        }
        
        print("mY = ", mY)
//        if mainScrollView == scrollView {
//            if mY <= 2 {
//                if mScrollView == scrollView {
//                    return true
//                }
//            }
//            return false
//        }
        
        return true
    }
    
    func scroll_gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if currentScrollDirection == .down {
            return false
        }
        return true 
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tag = scrollView.tag
        let y = scrollView.contentOffset.y
        if tag == 1 {
            print("tag = 1, y = ", y)
        } else if tag == 2 {
            print("tag = 2, y = ", y)
        } else {
            
        }
        
        
        if (y - self.scrollMaxY > 0) {
            self.scrollMaxY = y
            print("up")
            currentScrollDirection = .up
        } else if (self.scrollMaxY - y > 0) {
            self.scrollMaxY = y
            print("down")
            currentScrollDirection = .down
        }
    
        
        if currentScrollDirection == .up {
             
        } else if currentScrollDirection == .down {
            mainScrollView.contentOffset = CGPoint.zero
        } else {
            
        }
        
        
//        if mainScrollView.contentOffset.y < 100 {
//            if mScrollView.contentOffset.y > 10 {
//                mainScrollView.contentOffset = CGPoint(x: 0, y: 100)
//            } else {
//                if mainScrollView.contentOffset.y <= 0 {
//                    mainScrollView.contentOffset = CGPoint.zero
//                    print("mScrollView.contentOffset Y = ", mScrollView.contentOffset)
////                    mScrollView.contentOffset = CGPoint(x: 0, y: y)
//                } else {
//                    mScrollView.contentOffset = CGPoint.zero
//                }
//            }
//        } else {
//            mainScrollView.contentOffset = CGPoint(x: 0, y: 100)
//        }
    }
}


protocol GAScrollViewDelegate: class {
    func scroll_gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool
    func scroll_gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
}

class GAScrollView: UIScrollView, UIGestureRecognizerDelegate {
    
    weak var scroll_delegate: GAScrollViewDelegate?
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        guard let v = gestureRecognizer.view else {
//            return true
//        }
//        let tag = v.tag
//        let scrollView = (v as! UIScrollView)
//        if tag == 2 {
//            if scrollView.contentOffset.y <= 0 {
//                return false
//            }
//        }
//
//        return true
        
        return scroll_delegate?.scroll_gestureRecognizer(gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer) ?? true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        guard let v = gestureRecognizer.view else {
//            return true
//        }
//        let tag = v.tag
//        let scrollView = (v as! UIScrollView)
//        let y = scrollView.contentOffset.y
//
//        if tag == 1 {
//
//        }
//
//        if tag == 2 {
//            if y < 0 {
//                return false
//            }
//        }
//
//        return true
        return scroll_delegate?.scroll_gestureRecognizerShouldBegin(gestureRecognizer) ?? true
        
    }
}
