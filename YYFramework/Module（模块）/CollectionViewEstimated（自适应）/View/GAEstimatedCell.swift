//
//  GAEstimatedCell.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/26.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit
import SnapKit

class GAEstimatedCell: UICollectionViewCell {

    @IBOutlet weak var l: UILabel!
    @IBOutlet weak var l1: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.contentView.snp.makeConstraints { (make) in
//            make.left.right.top.bottom.equalTo(0)
//            make.width.equalTo(UIScreen.main.bounds.size.width / 2)
//        }
    }

    // 001
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        self.setNeedsLayout()
        self.layoutIfNeeded()

        let size = self.contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var cellFrame = layoutAttributes.frame
        cellFrame.size.height = size.height
        layoutAttributes.frame = cellFrame
        return layoutAttributes
    }
}
