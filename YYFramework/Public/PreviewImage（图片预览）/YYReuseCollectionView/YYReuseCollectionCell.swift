//
//  YYReuseCollectionCell.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/23.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYReuseCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!

    var image: UIImage! {
        didSet {
            imageView.image = image
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
