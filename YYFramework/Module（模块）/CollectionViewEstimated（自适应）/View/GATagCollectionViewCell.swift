//
//  ZHTagCollectionViewCell.swift
//  PuXinFinancial
//
//  Created by 侯佳男 on 2018/12/1.
//  Copyright © 2018年 ZHENGHE. All rights reserved.
//

import UIKit

class GATagCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    
    var model: String! {
        didSet {
            tagLabel.text = model
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
