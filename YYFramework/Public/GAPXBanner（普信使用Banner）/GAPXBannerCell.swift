//
//  GAPXBannerCell.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/10.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GAPXBannerCellDelegate: class {
    func bannerCellPlay(cell: GAPXBannerCell, row: Int)
}

class GAPXBannerCell: UICollectionViewCell {
    
    weak var mDelegate: GAPXBannerCellDelegate?
    
    var row: Int = -1
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func play(_ sender: Any) {
        mDelegate?.bannerCellPlay(cell: self, row: row)
    }
    
}
