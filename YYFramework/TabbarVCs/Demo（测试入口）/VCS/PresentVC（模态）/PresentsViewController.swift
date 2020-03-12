//
//  PresentsViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/19.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class PresentsViewController: GANavViewController {
    
    @IBAction func defaultPresent(_ sender: Any) {
        let vc = PresentTargetViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func custome(_ sender: Any) {
        GATimer(sourceTimerCount: 3, isRepeat: false).addTimer {
            [weak self] c, b in
            if let weakSelf = self {
                DispatchQueue.main.async {
                    let d = YYPresentationDelegate(animationType: .alert)
                    let vc = PresentTargetCustomeViewController(nibName: "PresentTargetCustomeViewController", bundle: nil, delegate: d)
                    guard let p = weakSelf._getPresentVC(vc: weakSelf) else {
                        return
                    }
                    //                vc.tLabel.text = c.toString()
                    p.present(vc, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    private func _getPresentVC(vc: UIViewController) -> UIViewController? {
        guard let p = vc.presentedViewController else {
            return vc
        }
        return _getPresentVC(vc: p)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "PresentVC")
    }
    
}


