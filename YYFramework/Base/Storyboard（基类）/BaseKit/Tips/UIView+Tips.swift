//
//  UIView+Tips.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

let TextOnlyTag = 99998
let LoadingTag = 99999

extension UIView {
    func show(_ text: String, touchEnable:Bool = true) -> Void {
        let tipsView: TipsXibView
        if let view = self.viewWithTag(TextOnlyTag) as? TipsXibView {
            tipsView = view
        } else {
            tipsView = TipsXibView.xibView()
            tipsView.tag = TextOnlyTag
            tipsView.type = .textOnly
            tipsView.frame = self.bounds
            tipsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        tipsView.textOnly.text = text
        tipsView.isUserInteractionEnabled = !touchEnable
        self.addSubview(tipsView)
        tipsView.perform(#selector(removeFromSuperview), with: nil, afterDelay: 3)
    }
    
    func show1(_ text: String, touchEnable:Bool = true) -> Void {
        
        let tipsView: TipsXibView
        if let view = self.viewWithTag(TextOnlyTag) as? TipsXibView {
            tipsView = view
        } else {
            tipsView = TipsXibView.xibView()
            tipsView.tag = TextOnlyTag
            tipsView.type = .textOnly
            tipsView.frame = self.bounds
            tipsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        tipsView.textOnly.text = text
        tipsView.isUserInteractionEnabled = !touchEnable
        self.addSubview(tipsView)
        tipsView.perform(#selector(removeFromSuperview), with: nil, afterDelay: 3)
    }
    
    func showLoading() -> Void {
        let tipsView: TipsXibView
        if let view = self.viewWithTag(LoadingTag) as? TipsXibView {
            tipsView = view
        } else {
            tipsView = TipsXibView.xibView()
            tipsView.tag = LoadingTag
            tipsView.type = .loading
            tipsView.frame = self.bounds
            tipsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        self.addSubview(tipsView)
    }
    
    func hideLoading() -> Void {
        self.viewWithTag(LoadingTag)?.removeFromSuperview()
    }
}
