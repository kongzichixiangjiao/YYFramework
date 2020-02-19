//
//  GATransitionableViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/30.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit
import TransitionableTab

class GATransitionableTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = [UITabBarItem(title: "1", image: nil, tag: 1), UITabBarItem(title: "2", image: nil, tag: 2), UITabBarItem(title: "3", image: nil, tag: 3)]
        
        let vc1 = TransitionableTabViewController01()
        vc1.tabBarItem = items[0]
        let vc2 = TransitionableTabViewController01()
        vc2.tabBarItem = items[1]
        let vc3 = TransitionableTabViewController01()
        vc3.tabBarItem = items[2]
        
        let vcs = [vc1, vc2, vc3]
        self.viewControllers = vcs
        
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension GATransitionableTabViewController: TransitionableTab {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return animateTransition(tabBarController, shouldSelect: viewController)
    }
    
//    func transitionDuration() -> CFTimeInterval {
//        return 2.0
//    }

//    func transitionTimingFunction() -> CAMediaTimingFunction {
//        return CAMediaTimingFunction.easeInOut
//    }
    
//    func fromTransitionAnimation(layer: CALayer?, direction: Direction) -> CAAnimation {
//
//    }
    
//    func toTransitionAnimation(layer: CALayer?, direction: Direction) -> CAAnimation {
//
//    }
}


class TransitionableTabViewController01: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
    }
}

