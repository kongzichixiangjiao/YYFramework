//
//  GAListPlaceholderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/28.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAListPlaceholderView: UIView {

    @IBOutlet weak var imgView: UIImageView!
    
    var imgName: String! {
        didSet {
            imgView.image = UIImage(named: imgName)
        }
    }
}
