//
//  GAKeyboardView.swift
//  Need
//
//  Created by houjianan on 2020/3/19.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GAKeyboardView: UIView {
    
    var keyboardObserver: KeyboardObserver!
    typealias TapHandler = () -> ()
    var beginTapHandler: TapHandler!
    var endTapHandler: TapHandler!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func observer(beginTapHandler: @escaping TapHandler, endTapHandler: @escaping TapHandler, changedHandler: @escaping (_ h: CGFloat) -> ()) {
        self.beginTapHandler = beginTapHandler
        self.endTapHandler = endTapHandler
        
        keyboardObserver = KeyboardObserver(view: self, beginHandler: { (h, dutaion) in
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height - self.frame.size.height - h, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
            changedHandler(h)
        }) { (_, dutaion) in
            changedHandler(0)
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height, width: UIScreen.main.bounds.size.width, height: self.frame.size.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func removeObserver() {
        keyboardObserver.keyboard_releaseNotification()
    }
}
