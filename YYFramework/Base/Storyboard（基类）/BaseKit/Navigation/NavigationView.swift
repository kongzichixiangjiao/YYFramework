//
//  NavigationView.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

class NavigationBarBackButton: UIButton {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return self.bounds.insetBy(dx: -15, dy: 0).contains(point)
    }
}

class NavigationView: UIView {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var shadowImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
