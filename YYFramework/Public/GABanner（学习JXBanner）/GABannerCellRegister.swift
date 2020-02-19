//
//  GABannerCellRegister.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

struct GABannerCellRegister {
    var type: UICollectionViewCell.Type?
    var reuseIdentifier: String
    var nib: UINib?

    public init(type: UICollectionViewCell.Type?, reuseIdentifier: String, nib: UINib? = nil) {
        self.type = type
        self.reuseIdentifier = reuseIdentifier
        self.nib = nib
    }
}
