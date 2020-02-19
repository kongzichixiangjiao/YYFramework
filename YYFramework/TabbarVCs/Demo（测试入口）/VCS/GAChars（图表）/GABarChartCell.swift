//
//  GABarChartCell.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/22.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GABarChartCell: UICollectionViewCell {

    @IBOutlet weak var charView: UIView!
    @IBOutlet weak var vHeight: NSLayoutConstraint!
    
    var mHeight: CGFloat! {
        didSet {
            vHeight.constant = mHeight
            charView.backgroundColor = UIColor.randomColor()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
