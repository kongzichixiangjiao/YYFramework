//
//  GANormalizeTabsMainCell.swift
//  YYFramework
//
//  Created by houjianan on 2019/6/10.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GANormalizeTabsMainCell: UICollectionViewCell {

    var row: Int = -1
    
    var mView: UIView! {
        didSet {
            for v in self.contentView.subviews {
                v.removeFromSuperview()
            }
            mView.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height)
            self.contentView.addSubview(mView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
